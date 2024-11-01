return {
    "lukas-reineke/indent-blankline.nvim",
    tag = 'v3.8.2',
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
