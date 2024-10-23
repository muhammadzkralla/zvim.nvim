return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
        require("ibl").setup({
            exclude = {
                filetypes = {
                    'lspinfo',
                    'lazy',
                    'checkhealth',
                    'help',
                    'man',
                    'dashboard',
                }
            }
        })
    end
}
