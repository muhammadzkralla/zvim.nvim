return {
    {
        "tpope/vim-fugitive"
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true, -- Enable current line blame by default
                current_line_blame_opts = {
                    delay = 500,           -- Optional: Delay before showing the blame, adjust as needed
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            })
            vim.keymap.set('n', '<C-g>', ':Gitsigns preview_hunk<CR>',
                { desc = "git preview", noremap = true, silent = true })
            vim.keymap.set('n', '<leader>gt', ':Gitsigns toggle_current_line_blame<CR>',
                { desc = "toggle blame", noremap = true, silent = true })
        end
    },
    -- nvim v0.8.0
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    }
}
