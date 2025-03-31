vim.cmd.colorscheme("no-clown-fiesta")

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

-- make the bg color black
-- vim.o.background = "dark"
-- vim.cmd("highlight Normal guibg=black")

-- Change the background color of floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3f4145" }) -- background color

-- Optionally, change the border color of floating windows
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e222a", fg = "#ffffff" }) -- Replace with desired color

-- Enable persistent undo
vim.opt.undofile = true

-- Set undo directory to LazyVim's location
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")

-- Reasonable limits for undo history
vim.opt.undolevels = 500  -- Save up to 500 undo steps per file
vim.opt.undoreload = 5000 -- Reload up to 5000 lines for undo

--autoread files
vim.opt.autoread = true

-- Enable highlighting for the word under the cursor
vim.opt.cursorline = true -- Highlight the current line
