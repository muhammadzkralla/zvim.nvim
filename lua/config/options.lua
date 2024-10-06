vim.cmd.colorscheme("night-owl")

vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Set tab width to 4 spaces
vim.opt.tabstop = 4

-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 4

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Ensure indentation when editing existing files follows the same
vim.opt.softtabstop = 4

-- Cursor settings
vim.opt.guicursor = "n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
vim.o.scrolloff = 10

-- Disable format on save globally
vim.g.autoformat = false

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Change the background color of floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3f4145" }) -- background color

-- Optionally, change the border color of floating windows
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e222a", fg = "#ffffff" }) -- Replace with desired colors

-- -- Enable highlighting for the word under the cursor
-- vim.opt.cursorline = true -- Highlight the current line
-- vim.opt.hlsearch = true   -- Highlight search results
--
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
--
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

-- Enable persistent undo
vim.opt.undofile = true

-- Set undo directory to LazyVim's location
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")
