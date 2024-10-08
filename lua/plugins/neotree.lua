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
                -- Use custom icons for different components
                default_component_configs = {
                    window = {
                        position = "left", -- Position NeoTree on the left
                        width = 35, -- Adjust width based on your preference
                    },
                    icon = {
                        folder_closed = icons.kinds.Folder,
                        folder_open = " ",
                        folder_empty = " ",
                        default = icons.kinds.File,
                    },
                    git_status = {
                        symbols = {
                            added     = icons.git.added,
                            modified  = icons.git.modified,
                            deleted   = icons.git.removed,
                            renamed   = "", -- icon for renamed files
                            untracked = "",
                            ignored   = "",
                            unstaged  = "",
                            staged    = "",
                            conflict  = "",
                        },
                    },
                },
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                    },   -- Automatically focus the file in the explorer
                    hijack_netrw_behavior = "open_current", -- Replace netrw
                },
            })
        end
    }
}
