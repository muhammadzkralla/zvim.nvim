return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "sainnhe/edge" },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "oxfist/night-owl.nvim",
    config = function()
      require("night-owl").setup()
    end,
  },
  { 'bettervim/yugen.nvim' }
}
