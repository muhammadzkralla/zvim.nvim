return {
    "ray-x/lsp_signature.nvim",
    config = function()
        require("lsp_signature").setup({
            bind = true,           -- This is mandatory
            handler_opts = {
                border = "rounded" -- Options: 'single', 'double', 'shadow', 'none'
            }
        })
    end,
}
