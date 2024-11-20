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
        },
        config = function()
            vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
            vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
            vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- customize lazygit popup window border characters
            vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
            vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

            vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
            vim.g.lazygit_config_file_path = '' -- custom config file path
            -- OR
            vim.g.lazygit_config_file_path = {} -- table of custom config file paths
        end
    }
}
