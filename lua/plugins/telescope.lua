return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
                extensions = {
                    themes = require('telescope.themes').get_dropdown({}),
                },
            })

            -- Keymap to bring up the colorscheme picker
            vim.keymap.set('n', '<leader>uC', function()
                require('telescope.builtin').colorscheme({
                    enable_preview = true, -- Shows preview of the colorschemes
                })
            end, { noremap = true, silent = true })
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end
    }
}
