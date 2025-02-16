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

            -- Function to toggle hidden & git-ignored files
            local function toggle_hidden()
                local state = require("neo-tree.sources.manager").get_state("filesystem")
                if state then
                    local filters = state.filtered_items
                    filters.visible = not filters.visible
                    filters.hide_dotfiles = not filters.hide_dotfiles
                    filters.hide_gitignored = not filters.hide_gitignored
                    require("neo-tree.sources.filesystem")._navigate_internal(state, nil, nil)
                end
            end

            -- Keymap to toggle hidden and git-ignored files
            vim.keymap.set('n', '<leader>th', toggle_hidden,
                { noremap = true, silent = true, desc = "Toggle Hidden Files" })

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
                    filtered_items = {
                        visible = true,  -- Show hidden files
                        hide_dotfiles = false,  -- Show dotfiles (e.g., `.gitignore`, `.env`)
                        hide_gitignored = false, -- Show files ignored by Git
                        hide_by_name = { "node_modules" }, -- You can customize which folders to hide
                    },
                },
            })
        end
    }
}
