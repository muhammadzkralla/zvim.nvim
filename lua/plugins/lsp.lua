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
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

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
                            fallback()             -- Insert a tab character
                        end
                    end, { 'i', 's' }),            -- In insert and select mode

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item() -- Navigate to previous completion item
                        else
                            fallback()             -- Insert a tab character
                        end
                    end, { 'i', 's' }),            -- In insert and select mode
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
                formatting = {
                    format = function(entry, item)
                        local icons = icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end

                        local widths = {
                            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
                            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
                        }

                        for key, width in pairs(widths) do
                            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
                            end
                        end

                        return item
                    end,
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

            require("lspconfig").lua_ls.setup {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "Lua 5.1" },
                        diagnostics = {
                            globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                        }
                    }
                }
            }

            require('lspconfig').kotlin_language_server.setup {
                cmd = { "kotlin-language-server" },
                filetypes = { "kotlin" },
                root_dir = function(fname)
                    return vim.loop.cwd() -- or adjust to a specific known directory
                end,
                autostart = true,
            }


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
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")
            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("java", { "javadoc" })
            local s = ls.snippet
            local i = ls.insert_node
            local t = ls.text_node

            -- these are my custom snippets for cpp problem solving
            ls.add_snippets("cpp", {
                -- GCD Function
                s("gcd", {
                    t("long long gcd(long long a, long long b) { // NOLINT(misc-no-recursion)"), t({ "", "\t" }),
                    t("if (b == 0) return a;"), t({ "", "\t" }),
                    t("return gcd(b, a % b);"), t({ "", "}" }),
                }),

                -- LCM Function
                s("lcm", {
                    t("long long lcm(long long a, long long b) {"), t({ "", "\t" }),
                    t("return (a * b) / gcd(a, b);"), t({ "", "}" }),
                }),

                -- isPrime Function
                s("isPrime", {
                    t("bool isPrime(long long number) {"), t({ "", "\t" }),
                    t("if (number <= 1) return false;"), t({ "", "\t" }),
                    t("for (int i = 2; i * i <= number; ++i) {"), t({ "", "\t\t" }),
                    t("if (number % i == 0) return false;"), t({ "", "\t" }),
                    t("}"), t({ "", "\t" }),
                    t("return true;"), t({ "", "}" }),
                }),

                -- for loop
                s("fori", {
                    t("for (int i = "), i(1), t("; i < "), i(2), t("; ++i) {"),
                    t({ "", "\t" }), i(0),
                    t({ "", "}" })
                }),

                -- for each
                s("forin", {
                    t("for ("), i(1), t(" : "), i(2), t(" ){"),
                    t({ "", "\t" }), i(0),
                    t({ "", "}" })
                }),

                -- convertToBinaryString Function
                s("convertToBinaryString", {
                    t("string convertToBinaryString(long long k) {"), t({ "", "\t" }),
                    t("string binaryString;"), t({ "", "" }),
                    t("\tif (k == 0) {"), t({ "", "\t\t" }),
                    t('binaryString = "0";'), t({ "", "\t" }),
                    t("} else {"), t({ "", "\t\t" }),
                    t("while (k > 0) {"), t({ "", "\t\t\t" }),
                    t("long long bit = k & 1;"), t({ "", "\t\t\t" }),
                    t('binaryString.insert(0, std::to_string(bit));'), t({ "", "\t\t\t" }),
                    t("k >>= 1;"), t({ "", "\t\t" }),
                    t("}"), t({ "", "\t" }),
                    t("}"), t({ "", "\t" }),
                    t("return binaryString;"), t({ "", "}" })
                }),

                -- nCr Function
                s("nCr", {
                    t("long long nCr(long long n, long long r) {"), t({ "", "\t" }),
                    t("long long ans = 1;"), t({ "", "\t" }),
                    t("long long div = 1;"), t({ "", "\t" }),
                    t("for (long long i = r + 1; i <= n; i++) {"), t({ "", "\t\t" }),
                    t("ans = ans * i;"), t({ "", "\t\t" }),
                    t("ans /= div;"), t({ "", "\t\t" }),
                    t("div++;"), t({ "", "\t" }),
                    t("}"), t({ "", "\t" }),
                    t("return ans;"), t({ "", "}" })
                }),

                -- nPr Function
                s("nPr", {
                    t("long long nPr(long long n, long long r) {"), t({ "", "\t" }),
                    t("long long ans = 1;"), t({ "", "\t" }),
                    t("for (long long i = (n - r) + 1; i <= n; i++) {"), t({ "", "\t\t" }),
                    t("ans *= i;"), t({ "", "\t\t" }),
                    t("ans %= mod;"), t({ "", "\t" }),
                    t("}"), t({ "", "\t" }),
                    t("return ans;"), t({ "", "}" })
                }),

                -- fact Function
                s("fact", {
                    t("long long fact(long long n) { // NOLINT(misc-no-recursion)"), t({ "", "\t" }),
                    t("if (n <= 1) return 1;"), t({ "", "\t" }),
                    t("return (n % mod * fact(n - 1) % mod) % mod;"), t({ "", "}" })
                }),

                -- convertToBaseK Function
                s("convertToBaseK", {
                    t("string convertToBaseK(long long n, int k) {"), t({ "", "\t" }),
                    t("string result;"), t({ "", "\t" }),
                    t("while (n > 0) {"), t({ "", "\t\t" }),
                    t("long long remainder = n % k;"), t({ "", "\t\t" }),
                    t("result.insert(0, to_string(remainder));"), t({ "", "\t\t" }),
                    t("n /= k;"), t({ "", "\t" }),
                    t("}"), t({ "", "\t" }),
                    t("return result;"), t({ "", "}" })
                }),
            })
        end,
    }
}
