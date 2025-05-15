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
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "ts_ls" }, -- Add more LSP servers you need
            })

            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        runtime = {
                            version = "Lua 5.3",
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
            --- Pyright
            vim.lsp.config('pyright', {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            pythonPath = "/usr/bin/python3",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = "basic",
                        },
                    },
                },
            })
            --- Arduino
            vim.lsp.config('arduino_language_server', {
                cmd = {
                    "arduino-language-server",
                    "-cli-config", "/home/zkrallah/.arduino15/arduino-cli.yaml",
                    "-fqbn", "esp32:esp32:esp32"
                },
                capabilities = capabilities,
            })
        end,
    }
}
