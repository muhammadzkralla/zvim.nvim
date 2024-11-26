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

-- Function to create a pop-up window for a question
local function create_popup(msg)
    return coroutine.create(function()
        -- Calculate popup dimensions
        local width = 50
        local height = 7
        local row = math.floor((vim.o.lines - height) / 2)  -- Center vertically
        local col = math.floor((vim.o.columns - width) / 2) -- Center horizontally

        -- Create a buffer
        local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer

        -- Add the title, centered
        local title_line = string.rep(" ", math.floor((width - #msg) / 2)) .. msg

        local lines = {
            "",
            title_line,
            "",
            "Press y to approve.",
            "Press n to cancel saving and return to buffer.",
            "Press q to abort questions and save anyway."
        }

        -- Set the content of the buffer
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

        -- Open a floating window
        local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,
            style = "minimal",
            border = "rounded",
            title = "Zpragmatic",
            title_pos = "center",
        })

        -- Get the user input
        vim.cmd("redraw")
        local answer = vim.fn.getcharstr()

        -- Close the pop-up
        vim.api.nvim_win_close(win, true)
        return answer
    end)
end

-- Function to prompt questions
local function prompt_questions(filetype)
    -- Get the questions for the specific filetype and default questions
    local specific_questions = M.config.filetype_questions[filetype] or {}
    local default_questions = M.config.filetype_questions["*"] or {}

    -- Merge the questions (default questions first, followed by specific questions)
    local questions = vim.list_extend(vim.deepcopy(default_questions), specific_questions)

    for _, question in ipairs(questions) do
        local co = create_popup(question)
        local _, answer = coroutine.resume(co)

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

local my_group = vim.api.nvim_create_augroup("zpragmatic", { clear = true })

vim.api.nvim_create_autocmd("BufWriteCmd", {
    group = my_group,
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
            print("Save aborted for failed checks, returning back to buffer.")
            return
        end

        -- Perform the save operation if all checks pass
        local filepath = vim.api.nvim_buf_get_name(0)
        vim.cmd("write! " .. filepath)
    end,
})

return M
