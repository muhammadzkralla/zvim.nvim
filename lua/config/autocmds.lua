-- Define a custom highlight group for yank highlighting
vim.cmd [[
  highlight YankHighlight guibg=#FFD700 guifg=#000000 ctermbg=214 ctermfg=0
]]
--
-- -- Optional: Add highlighting on yank (copy)
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        -- Use the custom highlight group for yank highlighting
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
