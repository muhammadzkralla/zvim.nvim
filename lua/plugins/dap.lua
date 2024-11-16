return {
    -- NIO library required by nvim-dap-ui
    {
        "nvim-neotest/nvim-nio", -- Add nvim-nio here
        lazy = true,
    },
    -- DAP for debugging
    {
        "mfussenegger/nvim-dap",
        config = function()
            -- Optional: Configure basic keybindings here if needed
            local dap = require("dap")
            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command =
                '/home/zkrallah/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
            }

            dap.adapters.codelldb = {
                type = 'server',
                port = "${port}",
                executable = {
                    command = '/home/zkrallah/.local/share/nvim/mason/bin/codelldb', -- Path to lldb-vscode
                    args = { "--port", "${port}" },
                },
                name = "lldb"
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file using cpppdbg",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = true,
                },
                {
                    name = "Launch file using codelldb",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = false,
                    args = {},
                    runInTerminal = false,
                },
                {
                    name = 'Attach to gdbserver :1234',
                    type = 'cppdbg',
                    request = 'launch',
                    MIMode = 'gdb',
                    miDebuggerServerAddress = 'localhost:1234',
                    miDebuggerPath = '/usr/bin/gdb',
                    cwd = '${workspaceFolder}',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                },
            }

            -- Example keymaps
            vim.keymap.set("n", "<F5>", dap.continue, { noremap = true, silent = true })
            vim.keymap.set("n", "<F8>", dap.step_over, { noremap = true, silent = true })
            vim.keymap.set("n", "<F7>", dap.step_into, { noremap = true, silent = true })
            vim.keymap.set("n", "<F9>", dap.step_out, { noremap = true, silent = true })
            vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { noremap = true, silent = true })
        end
    },

    -- DAP UI for a better debugging experience
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
            vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'red', linehl = '', numhl = '' })

            -- Optional: Auto-open/close DAP UI when debugging starts/stops
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },

    -- Mason integration for DAPs
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "python", "cppdbg", "cpptools" }, -- Install specific debuggers (e.g., Python, C++)
                automatic_installation = true,
            })
        end
    }
}
