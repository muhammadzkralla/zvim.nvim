local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- undo
vim.keymap.set("i", "<C-z>", "<Esc>ua", { desc = "undo", noremap = true, silent = true })
vim.keymap.set("n", "<C-z>", "u", { desc = "undo", noremap = true, silent = true })

-- redo
vim.keymap.set("i", "<C-r>", "<Esc><C-r>a", { desc = "redo", noremap = true, silent = true })
vim.keymap.set("n", "<C-r>", "<C-r>", { desc = "redo", noremap = true, silent = true })

-- select all
vim.keymap.set("i", "<C-a>", "<Esc>ggVGa", { desc = "select all", noremap = true, silent = true })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "select all", noremap = true, silent = true })

-- cut to system clipboard (normal mode)
vim.keymap.set("n", "<C-x>", '"+d', { desc = "cut to system clipboard", noremap = true, silent = true })

-- copy to system clipboard (normal mode)
vim.keymap.set("n", "<C-c>", '"+y', { desc = "copy to system clipboard", noremap = true, silent = true })

-- paste from system clipboard (normal mode)
vim.keymap.set("n", "<C-v>", '"+p', { desc = "paste from system clipboard", noremap = true, silent = true })

-- cut to system clipboard (visual mode)
vim.keymap.set("x", "<C-x>", '"+d', { desc = "cut to system clipboard", noremap = true, silent = true })

-- copy to system clipboard (visual mode)
vim.keymap.set("x", "<C-c>", '"+y', { desc = "copy to system clipboard", noremap = true, silent = true })

-- paste from system clipboard (insert mode)
vim.keymap.set("i", "<C-v>", '<Esci>"+pgI', { desc = "paste from system clipboard", noremap = true, silent = true })

-- Key mapping for Ctrl+s to save the current file in Normal mode
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- Key mapping for Ctrl+s to save the current file in Insert mode and stay in Insert mode
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- Open code actions with Ctrl-Q in normal mode
vim.keymap.set(
    "n",
    "<C-q>",
    "<cmd>lua vim.lsp.buf.code_action()<CR>",
    { noremap = true, silent = true, desc = "Open code actions" }
)

-- Open code actions with Ctrl-Q in insert mode (switches to normal mode first)
vim.keymap.set(
    "i",
    "<C-q>",
    "<Esc><cmd>lua vim.lsp.buf.code_action()<CR>i",
    { noremap = true, silent = true, desc = "Open code actions" }
)

-- show function signature help (normal mode)
vim.keymap.set(
    "n",
    "<C-p>",
    vim.lsp.buf.signature_help,
    { desc = "Show function signature help", noremap = true, silent = true }
)

-- show function signature_help (insert mode)
vim.keymap.set(
    "i",
    "<C-p>a",
    vim.lsp.buf.signature_help,
    { desc = "Show function signature help", noremap = true, silent = true }
)

-- Optimize imports in normal mode
vim.keymap.set(
    "n",
    "<C-i>",
    '<cmd>lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } } })<CR>',
    { noremap = true, silent = true, desc = "Optimize Imports" }
)

-- Optimize imports in insert mode (switches to normal mode first)
vim.keymap.set(
    "i",
    "<C-i>",
    '<Esc><cmd>lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } } })<CR>i',
    { noremap = true, silent = true, desc = "Optimize Imports" }
)

-- Go to declaration in normal mode with Ctrl-D
vim.keymap.set("n", "<C-d>", function()
    vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "Go to declaration" })

-- Go to declaration in insert mode with Ctrl-D
vim.keymap.set("i", "<C-d>", function()
    vim.cmd([[stopinsert]]) -- Exit insert mode
    vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "Go to declaration" })

-- list references in normal mode
vim.keymap.set(
    "n",
    "<C-e>",
    "<cmd>Telescope lsp_references<cr>",
    { noremap = true, silent = true, desc = "List references" }
)

-- list references in insert mode
vim.keymap.set(
    "i",
    "<C-e>",
    "<Esc><cmd>Telescope lsp_references<cr>i",
    { noremap = true, silent = true, desc = "List references" }
)

-- Normal mode
vim.keymap.set("n", "<C-n>", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename", noremap = true, silent = true })

-- Insert mode
vim.keymap.set(
    "i",
    "<C-n>",
    "<cmd>lua vim.cmd('stopinsert')<CR><cmd>lua vim.lsp.buf.rename()<CR><cmd>lua vim.cmd('startinsert')<CR>",
    { desc = "Rename", noremap = true, silent = true }
)

-- select and move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "select and move", noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "select and move", noremap = true, silent = true })

--bufferlin
-- Key mappings for buffer navigation and management
vim.api.nvim_set_keymap('n', 'H', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })            -- Go to the left buffer
vim.api.nvim_set_keymap('n', 'L', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })            -- Go to the right buffer
vim.api.nvim_set_keymap('n', '<leader>bd', '<cmd>bdelete<CR>', { noremap = true, silent = true })               -- Close current buffer
vim.api.nvim_set_keymap('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', { noremap = true, silent = true }) -- Close other buffers

--code formatting
-- Keymap for formatting code using LSP
vim.keymap.set("n", "<C-f>", function()
    vim.lsp.buf.format({
        async = true,
        -- You can specify filters here to choose certain LSP servers for formatting, like:
        -- filter = function(client) return client.name == "tsserver" end
    })
end, { desc = "Format Code" })

-- Keymap to format only the selected code in visual mode
vim.keymap.set("v", "<C-f>", function()
    vim.lsp.buf.format({
        async = true,
        range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
        }
    })
end, { desc = "Format Selected Code" })

-- -- Keymaps for switching windows
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { desc = "left window", noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { desc = "right window", noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { desc = "bottom window", noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { desc = "top window", noremap = true, silent = true })

vim.keymap.set('n', '<C-b>', function() require('telescope.builtin').live_grep() end,
    { desc = "find text", noremap = true, silent = true })

-- delete
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'dd', '"_dd', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'dw', '"_dw', { noremap = true, silent = true })
