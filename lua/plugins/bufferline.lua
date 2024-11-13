return {
    -- Bufferline configuration
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup {
                options = {
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    middle_mouse_command = "bdelete! %d",
                    indicator = {
                        icon = "☕",
                        style = "icon", -- Highlight active buffer with underline for clarity
                    },
                    offsets = {
                        { filetype = "neo-tree", text = "File Explorer", highlight = "Directory", text_align = "left" }
                    },
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local error_count = diagnostics_dict.error or 0
                        return error_count > 0 and "  " .. error_count or ""
                    end,
                    buffer_close_icon = "", -- Custom close icon
                    close_icon = "-", -- Icon for closing all the tabs
                    modified_icon = "●", -- Icon for modified buffers
                    left_trunc_marker = "", -- Marker for left overflow
                    right_trunc_marker = "", -- Marker for right overflow
                    max_name_length = 18, -- Set a max buffer name length
                    max_prefix_length = 15, -- Set a max prefix length for truncated buffers
                    tab_size = 20, -- Set minimum tab size for buffers
                    separator_style = "thick", -- Stylish separatorstics = "nvim_lsp",
                    enforce_regular_tabs = true, -- Ensure all tabs are the same width
                    color_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    persist_buffer_sort = true, -- Keep custom sorting
                },
            }
        end,
    },
}
