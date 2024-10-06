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
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                    })
                end,
                -- Add more custom setups for specific servers if needed
            })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({
                bind = true,           -- This is mandatory
                handler_opts = {
                    border = "rounded" -- Options: 'single', 'double', 'shadow', 'none'
                }
            })
        end,
    },
    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",                    -- Completion framework
            "hrsh7th/cmp-nvim-lsp",                -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",                  -- Buffer source for nvim-cmp
            "hrsh7th/cmp-path",                    -- Path source for nvim-cmp
            "L3MON4D3/LuaSnip",                    -- Snippet engine
            "saadparwaiz1/cmp_luasnip",            -- Snippet completion
            "rafamadriz/friendly-snippets",        -- Snippet collection
            "hrsh7th/cmp-nvim-lsp-signature-help", -- LSP signature help source
        },
        config = function()
            -- Diagnostic options with signs configured
            vim.diagnostic.config({
                -- virtual_text = false, -- Disable virtual text (optional)
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                    -- prefix = "icons",
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error, -- Error icon
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,   -- Warning icon
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,   -- Hint icon
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,   -- Info icon
                    },
                },
                update_in_insert = false,
                severity_sort = true,
            })

            -- Key mappings for diagnostic navigation
            vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>',
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>',
                { noremap = true, silent = true })
            -- vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>',
            --     { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>',
                { noremap = true, silent = true })

            -- Show floating diagnostics automatically on hover
            vim.api.nvim_create_autocmd("CursorHold", {
                callback = function()
                    vim.diagnostic.open_float(nil, { focusable = false })
                end,
            })

            -- Autocompletion configuration
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = {
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item() -- Navigate to next completion item
                        else
                            fallback() -- Insert a tab character
                        end
                    end, { 'i', 's' }), -- In insert and select mode

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item() -- Navigate to previous completion item
                        else
                            fallback() -- Insert a tab character
                        end
                    end, { 'i', 's' }), -- In insert and select mode
                    ['<Down>'] = cmp.mapping.select_next_item(),
                    ['<Up>'] = cmp.mapping.select_prev_item(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert" .. ("" and "" or ",noselect"),
                },
                experimental = {
                    ghost_text = true
                },
            })

            -- Setup LSP servers
            require("mason-lspconfig").setup_handlers({
                function(server_name) -- Default handler
                    require("lspconfig")[server_name].setup({
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        on_attach = function(client, bufnr)
                            -- Enable signature help
                            require("lsp_signature").on_attach({
                                bind = true,
                                handler_opts = {
                                    border = "rounded"
                                },
                                toggle_key = '<M-x>',
                            }, bufnr)
                        end,
                    })
                end,
            })

            -- Use buffer source for `/` in command mode
            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for `:` in command mode
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })

            -- Load snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    }
}
