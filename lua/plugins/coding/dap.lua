-- Debug adapter protocol

-- Wrapper function to set keymaps with default opts
local map = function(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true, desc = 'DAP: ' .. desc }
    vim.keymap.set(mode, lhs, rhs, opts)
end

return {
    'mfussenegger/nvim-dap', -- debug adapter protocol
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        {
            'rcarriga/nvim-dap-ui', -- UI for nvim-dap
            opts = {},
        },
        {
            'jay-babu/mason-nvim-dap.nvim', -- bridges mason.nvim and nvim-dap
            opts = {
                ensure_installed = { 'python', 'codelldb' },
                automatic_installation = true,
            },
        },
        {
            'LiadOz/nvim-dap-repl-highlights', -- syntax highlights to nvim-dap REPL
            dependencies = 'nvim-treesitter/nvim-treesitter',
            build = ':TSInstall dap_repl',
            opts = {},
        },
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

        -- --------------------------------------------------------------------
        -- Configurations for each languages
        -- --------------------------------------------------------------------
        -- NOTE: For per-project config, create .vscode/launch.json that looks something like this:
        -- {
        --   // Use IntelliSense to learn about possible attributes.
        --   // Hover to view descriptions of existing attributes.
        --   // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
        --   "version": "0.2.0",
        --   "configurations": [
        --     {
        --       "name": "NAME OF THE LAUNCH",
        --       "type": "python",
        --       "request": "launch",
        --       "program": "${file}",
        --       "console": "integratedTerminal",
        --       "args": ["TOKEN1", "TOKEN2", ...]
        --     }
        --   ]
        -- }

        -- Python - debugpy ---------------------------------------------------
        dap.adapters.python = {
            type = 'executable',
            command = vim.g.python3_host_prog,
            args = { '-m', 'debugpy.adapter', },
        }
        dap.configurations.python = {
            {
                name = '[Default] Launch DAP (debugpy) for the current file',
                type = 'python',
                request = 'launch',
                program = '${file}',
                console = 'integratedTerminal',
                cwd = '${workspaceFolder}',
                repl_lang = 'javascript',
                args = {},
            },
            {
                name = '[Default] Launch DAP (debugpy) with file selection',
                type = 'python',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                console = 'integratedTerminal',
                cwd = '${workspaceFolder}',
                repl_lang = 'javascript',
                args = {},
            },
        }

        -- C/C++ - codelldb ---------------------------------------------------
        -- NOTE:your code has to be compiled first, e.g., using
        -- g++ -g main.cpp -o [output_name]
        -- Then provide [output_name] as the program name
        dap.adapters.lldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/codelldb',
                args = {'--port', '${port}'},
                -- On windows you may have to uncomment this:
                -- detached = false,
            }
        }
        dap.configurations.cpp = {
            {
                name = '[Default] Launch DAP (codelldb) with file selection',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                console = 'integratedTerminal',
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
            },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp

        -- --------------------------------------------------------------------
        -- Automatically open when a debug session is created
        -- --------------------------------------------------------------------
        dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
        end

        -- --------------------------------------------------------------------
        -- Set up signs and colors
        -- --------------------------------------------------------------------
        vim.fn.sign_define('DapBreakpoint',          { text = '🛑', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '🔶', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        vim.fn.sign_define('DapLogPoint',            { text = '📜', texthl = 'DapLogPoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped',             { text = '👀', texthl = '', linehl = 'debugPC', numhl = '' })
        vim.fn.sign_define('DapBreakpointRejected',  { text = '🚫', texthl = '', linehl = '', numhl = '' })

        -- --------------------------------------------------------------------
        -- Set up keymaps
        -- --------------------------------------------------------------------
        map('n', ',d', function() dapui.toggle() end, 'Toggle UI')
        map('n', ',D', function() dap.repl.toggle() end, 'Open default REPL')
        map('n', ',k', function() require('dap.ui.widgets').hover() end, 'Check variable value on hover')

        map('n', ',c', function()
            if vim.fn.filereadable('.vscode/launch.json') then
                require('dap.ext.vscode').load_launchjs()
            end
            dap.continue()
        end, 'Start/Continue debugging')
        map('n', ',l', function() dap.run_last() end, 'Run the last debug adapter entry')
        map('n', ',b', function() dap.toggle_breakpoint() end, 'Toggle breakpoint')
        map('n', ',B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, 'Toggle breakpoint with condition')
        map('n', ',n', function() dap.step_over() end, 'Step over')
        map('n', ',s', function() dap.step_into() end, 'Step into')
        map('n', ',u', function() dap.step_out() end, 'Step out')
        map('n', ',t', function() dap.terminate() end, 'Terminate debugging')
        -- map('n', ',r', function() dap.run() end, 'Run debugging')
    end
}
