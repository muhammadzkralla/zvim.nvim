-- Set up yank highlighting
vim.api.nvim_create_augroup('YankHighlight', { clear = true })

-- Ensure the highlight group is defined after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
    group = "YankHighlight",
    pattern = "*",
    callback = function()
        vim.cmd [[highlight YankHighlight guibg=#FFD700 guifg=#000000 ctermbg=214 ctermfg=0]]
    end,
})

-- Create the autocmd for highlighting on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank({ timeout = 200, higroup = 'YankHighlight' })
    end,
})
-- -- Variable to store the current match ID
-- local current_match_id = -1
--
-- -- Function to highlight the current word under the cursor
-- local function highlight_word()
--     -- Clear previous highlights if any
--     if current_match_id > 0 then
--         local success, _ = pcall(vim.fn.matchdelete, current_match_id)
--         if not success then
--             print("Error deleting match: ID not found")
--         end
--     end
--
--     -- Get the word under the cursor
--     local word = vim.fn.expand('<cword>')
--
--     if word ~= '' then
--         -- Highlight the current word and all its occurrences
--         current_match_id = vim.fn.matchadd('Search', '\\<' .. word .. '\\>')
--     else
--         -- Reset match ID if no word is found
--         current_match_id = -1
--     end
-- end
--
-- -- Auto-command group for highlighting
-- vim.api.nvim_create_augroup('HighlightWord', { clear = true })
-- vim.api.nvim_create_autocmd('CursorMoved', {
--     group = 'HighlightWord',
--     callback = highlight_word,
-- })
