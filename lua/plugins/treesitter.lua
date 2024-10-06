return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate', -- Automatically update parsers on update
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "lua", "javascript", "python", "bash", "java", "c", "markdown" }, -- Add other languages as needed
      highlight = { enable = true }, -- Enable syntax highlighting using Tree-sitter
      indent = { enable = true }, -- Enable indentation based on Tree-sitter
      -- You can add other Tree-sitter modules here as needed
    }
  end
}
