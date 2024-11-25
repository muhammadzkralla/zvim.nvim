local M = {}

M.config = {
    filetype_questions = {
        ["*"] = {
            "Save changes? (y/n/q): ",
        },
        ["java"] = {
            "Did you check for syntax errors? (y/n/q): ",
            "Are all tests passing? (y/n/q): ",
        },
        ["javascript"] = {
            "Did you run the linter? (y/n/q): ",
            "Are there any console logs to remove? (y/n/q): ",
        },
    },
    bypass_filetypes = { "markdown", "txt", "json" },
}

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

-- TODO: Create a prompt dialog instead of regular vim command questions.
local function prompt_questions(filetype)
    -- Get the questions for the specific filetype and default questions
    local specific_questions = M.config.filetype_questions[filetype] or {}
    local default_questions = M.config.filetype_questions["*"] or {}

    -- Merge the questions (default questions first, followed by specific questions)
    local questions = vim.list_extend(vim.deepcopy(default_questions), specific_questions)

    for _, question in ipairs(questions) do
        local answer = vim.fn.input(question)
        if answer:lower() == "q" then
            print("Process aborted")
            return true
        elseif answer:lower() ~= "y" then
            print("Save cancelled")
            return false
        end
    end
    return true
end

vim.api.nvim_create_autocmd("BufWriteCmd", {
    callback = function()
        -- Get the file type
        local filetype = vim.bo.filetype

        -- Check if the file type is in the bypass list
        if vim.tbl_contains(M.config.bypass_filetypes, filetype) then
            -- Perform the save operation as normal
            local filepath = vim.api.nvim_buf_get_name(0)
            vim.cmd("write! " .. filepath)
            return
        end

        -- Prompt questions, cancel save if necessary
        if not prompt_questions(filetype) then
            vim.api.nvim_err_writeln("Save aborted for failed checks, returning back to buffer.")
            return
        end

        -- Perform the save operation if all checks pass
        local filepath = vim.api.nvim_buf_get_name(0)
        vim.cmd("write! " .. filepath)
    end,
})

return M
