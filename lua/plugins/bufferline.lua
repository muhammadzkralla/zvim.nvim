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
          offsets = {
            { filetype = "neo-tree", text = "File Explorer", highlight = "Directory", text_align = "left" }
          },
          separator_style = "thin",
          diagnostics = "nvim_lsp",
          color_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = true,
        },
      }
    end,
  },
}
