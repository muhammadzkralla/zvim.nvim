return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- Optional, for file icons
            "MunifTanjim/nui.nvim",
        },
        config = function()
            -- Set keymap for toggling Neo-tree with <leader>e
            vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true, noremap = true })
            -- Set keymap for toggling Git status with <leader>ge
            vim.keymap.set('n', '<leader>ge', ':Neotree toggle git_status<CR>', { silent = true, noremap = true })

            -- Optionally configure Neo-tree here
            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = true,   -- Automatically focus the file in the explorer
                    hijack_netrw_behavior = "open_current", -- Replace netrw
                },
            })
        end
    }
}
