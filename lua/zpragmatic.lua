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

local function prompt_questions(filetype)
    local questions = M.config.filetype_questions[filetype] or M.config.filetype_questions["*"]

    for _, question in ipairs(questions) do
        local answer = vim.fn.input(question)
        if answer:lower() == "q" then
            print("Process aborted")
            return false
        elseif answer:lower() ~= "y" then
            print("Save cancelled")
            return false
        end
    end
    return true
end

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local filetype = vim.bo.filetype
        if vim.tbl_contains(M.config.bypass_filetypes, filetype) then
            return
        end
        if not prompt_questions(filetype) then
            vim.api.nvim_command("echohl WarningMsg | echom 'Save cancelled or aborted' | echohl None")
            vim.cmd("echo ''")
            return true
        end
    end,
})

return M
