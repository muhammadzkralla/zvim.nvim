return {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
        require("presence").setup({
            auto_update        = true,
            neovim_image_text  = "NeoVim, btw",
            main_image         = "neovim",
            log_level          = nil,
            debounce_timeout   = 10,
            enable_line_number = false,
            buttons            = false,
            show_time          = true,
            idle_text          = "Browsing the dashboard...",
        })

        -- vim.api.nvim_create_autocmd("User", {
        --     pattern = "DashboardReady",
        --     callback = function()
        --         require("presence"):update()
        --     end,
        -- })
    end,
}
