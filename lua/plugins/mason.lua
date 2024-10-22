return {
    -- Mason for managing LSP servers
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "ts_ls" }, -- Add more LSP servers you need
            })

            require("mason-lspconfig").setup_handlers({
                function(server_name) -- Default handler
                    require("lspconfig")[server_name].setup({
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        on_attach = function(client, bufnr)
                            -- Optional: Custom on_attach function to set keymaps, etc.
                        end,
                    })
                end,

                -- Custom setup for Lua language server
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "Lua 5.1",
                                },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true), -- Make Neovim runtime files discoverable
                                    checkThirdParty = false,                           -- Avoid popping up workspace notifications
                                },
                                telemetry = {
                                    enable = false, -- Disable telemetry to avoid sending data
                                },
                                codeLens = {
                                    enable = true,
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                                doc = {
                                    privateName = { "^_" },
                                },
                                hint = {
                                    enable = true,
                                    setType = false,
                                    paramType = true,
                                    paramName = "Disable",
                                    semicolon = "Disable",
                                    arrayIndex = "Disable",
                                },
                            },
                        },
                    })
                end,

                ["kotlin_language_server"] = function()
                    require('lspconfig').kotlin_language_server.setup({
                        cmd = { 'kotlin-language-server' },
                        root_dir = require('lspconfig.util').root_pattern('settings.gradle', 'settings.gradle.kts',
                            'build.gradle', 'build.gradle.kts', 'pom.xml', '.git'),
                        on_attach = function(client, bufnr)
                            -- Set up buffer-local keybindings, etc.
                        end,
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                    })
                end

            })
        end,
    }
}
