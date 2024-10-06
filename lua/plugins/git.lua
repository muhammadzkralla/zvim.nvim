return {
    {
        "tpope/vim-fugitive"
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>',
                { desc = "git preview", noremap = true, silent = true })
            vim.keymap.set('n', '<leader>gt', ':Gitsigns toggle_current_line_blame<CR>',
                { desc = "toggle blame", noremap = true, silent = true })
        end
    }
}
