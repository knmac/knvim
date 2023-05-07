-- Debug adapter protocol
return {
    'mfussenegger/nvim-dap', -- debug adapter protocol
    event = 'VeryLazy',
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
            opts = {},
        },
    },
    config = function()
        local dap = require('dap')

        -- Configurations for each languages ------------------------------------------
        -- Python - debugpy
        dap.adapters.python = {
            type = 'executable',
            command = vim.g.python3_host_prog,
            args = { '-m', 'debugpy.adapter', },
        }
        dap.configurations.python = {
            {
                name = '[Default] Launch DAP for the current file',
                type = 'python',
                request = 'launch',
                console = 'integratedTerminal',
                cwd = '${workspaceFolder}',
                program = '${file}',
                repl_lang = 'javascript',
                args = {},
            },
            {
                name = '[Default] Launch DAP with file selection',
                type = 'python',
                request = 'launch',
                console = 'integratedTerminal',
                cwd = '${workspaceFolder}',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                repl_lang = 'javascript',
                args = {},
            },
        }

        -- TODO: C/C++ - codelldb

        -- Set up signs and colors
        vim.fn.sign_define('DapBreakpoint',          { text = '🛑', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '🔶', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        vim.fn.sign_define('DapLogPoint',            { text = '📜', texthl = 'DapLogPoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped',             { text = '👀', texthl = '', linehl = 'debugPC', numhl = '' })
        vim.fn.sign_define('DapBreakpointRejected',  { text = '🚫', texthl = '', linehl = '', numhl = '' })

        -- Wrapper function to set keymaps with default opts
        local map = function(mode, lhs, rhs, desc)
            local opts = { noremap = true, silent = true, desc = 'DAP: ' .. desc }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Set up keymaps
        map('n', ',d', function() require('dapui').toggle() end, 'Toggle UI')
        map('n', ',k', function() require('dap.ui.widgets').hover() end, 'Check variable value on hover')

        map('n', ',c', function()
            if vim.fn.filereadable('.vscode/launch.json') then
                require('dap.ext.vscode').load_launchjs()
            end
            dap.continue()
        end, 'Start/Continue debugging')
        map('n', ',l', function() dap.run_last() end, 'Run the last debug adapter entry')
        map('n', ',b', function() dap.toggle_breakpoint() end, 'Toggle breakpoint')
        map('n', ',B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
            'Toggle breakpoint with condition')
        map('n', ',n', function() dap.step_over() end, 'Step over')
        map('n', ',s', function() dap.step_into() end, 'Step into')
        map('n', ',u', function() dap.step_out() end, 'Step out')
        map('n', ',t', function() dap.terminate() end, 'Terminate debugging')
        -- map('n', ',r', function() dap.run() end, 'Run debugging')
    end
}
