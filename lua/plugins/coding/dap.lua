-- Debug adapter protocol
local python_launcher_template = [[
{
  "version": "0.2.0",
    "configurations": [
    {
      "type": "python",
      "request": "launch",
      "name": "launcher name",
      "program": "${file}",
      "console": "integratedTerminal",
      "cwd": "${workspaceFolder}",
      "repl_lang": "javascript",
      "args": []
    }
  ]
}]]

local generate_python_launher = function()
    local fname = ".vscode/launch.json"
    local f = io.open(fname, "r")
    if f ~= nil then
        io.close(f)
        return
    end

    require("os").execute("mkdir -p .vscode")
    local file, err = io.open(fname, "w")
    if file then
        file:write(python_launcher_template)
        file:close()
        print(fname .. " generated")
    else
        print(err)
    end
end

return {
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    -- Mason DAP
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    {
        "jay-babu/mason-nvim-dap.nvim", -- bridges mason.nvim and nvim-dap
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
        opts = {
            ensure_installed = { "python", "codelldb", "bash" },
            automatic_installation = true,
        },
    },
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    -- DAP view
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    {
        "igorlfs/nvim-dap-view",
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
        keys = {
            { ",d", function() require("dap-view").toggle() end, desc = "DAP: Toggle UI" },
        },
        opts = {},
    },
    {
        "LiadOz/nvim-dap-repl-highlights", -- syntax highlights to nvim-dap REPL
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
        dependencies = "nvim-treesitter/nvim-treesitter",
        build = ":TSInstall dap_repl",
        opts = {},
    },
    -- {
    --     "rcarriga/nvim-dap-ui", -- UI for nvim-dap
    --     event = { "BufReadPre", "BufNewFile" },
    --     -- event = "VeryLazy",
    --     keys = {
    --         { ",d", function() require("dapui").toggle() end, desc = "DAP: Toggle UI" },
    --     },
    --     opts = {},
    -- },
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    -- DAP
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    {
        "mfussenegger/nvim-dap", -- debug adapter protocol
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
        dependencies = {
        },
        keys = {
            -- { ",D", function() require("dap").repl.toggle() end,       desc = "DAP: Open default REPL" },
            { ",c", function() require("dap").continue() end,          desc = "DAP: Start/Continue debugging", },
            { ",l", function() require("dap").run_last() end,          desc = "DAP: Run the last debug adapter entry" },
            { ",b", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
            { ",n", function() require("dap").step_over() end,         desc = "DAP: Step over" },
            { ",s", function() require("dap").step_into() end,         desc = "DAP: Step into" },
            { ",u", function() require("dap").step_out() end,          desc = "DAP: Step out" },
            { ",t", function() require("dap").terminate() end,         desc = "DAP: Terminate debugging" },
            {
                ",B",
                function()
                    vim.ui.input(
                        { prompt = "Breakpoint condition: " },
                        function(input)
                            require("dap").set_breakpoint(input)
                        end
                    )
                end,
                desc = "DAP: Toggle breakpoint with condition",
            },
            { ",g", generate_python_launher, desc = "DAP: Generate launcher for Python" },
            {
                ",k",
                function() require("dap.ui.widgets").hover(nil, { border = "rounded" }) end,
                desc = "DAP: Check variable value on hover",
            },
            {
                ",S",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.scopes, { border = "rounded" })
                end,
                desc = "DAP: Open scope",
            },
        },
        init = function()
            local dap = require("dap")

            -- Configurations for each languages ──────────────────────────────────────────────────
            -- Python - debugpY
            -- dap.adapters.python = {
            --     type = "executable",
            --     command = vim.g.python3_host_prog,
            --     args = { "-m", "debugpy.adapter", },
            -- }
            dap.adapters.python = function(cb, config)
                if config.request == "attach" then
                    local port = (config.connect or config).port
                    local host = (config.connect or config).host or "127.0.0.1"
                    cb({
                        type = "server",
                        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                        host = host,
                        options = {
                            source_filetype = "python",
                        },
                    })
                else
                    cb({
                        type = "executable",
                        command = vim.g.python3_host_prog,
                        args = { "-m", "debugpy.adapter" },
                        options = {
                            source_filetype = "python",
                        },
                    })
                end
            end
            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "[Default] Launch DAP (debugpy) for the current file",
                    program = "${file}",
                    console = "integratedTerminal",
                    cwd = "${workspaceFolder}",
                    repl_lang = "javascript",
                    args = {},
                },
                {
                    type = "python",
                    request = "launch",
                    name = "[Default] Launch DAP (debugpy) with file selection",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    console = "integratedTerminal",
                    cwd = "${workspaceFolder}",
                    repl_lang = "javascript",
                    args = {},
                },
            }

            -- C/C++ - codelldb
            -- NOTE:your code has to be compiled first, e.g., using
            -- g++ -g main.cpp -o [output_name]
            -- Then provide [output_name] as the program name
            dap.adapters.lldb = {
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
                name = "lldb",
            }
            dap.configurations.cpp = {
                {
                    type = "lldb",
                    request = "launch",
                    name = "[Default] Launch DAP (codelldb) with file selection",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            -- Bash - bashdb
            dap.adapters.bashdb = {
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
                name = "bashdb",
            }
            dap.configurations.sh = {
                {
                    type = "bashdb",
                    request = "launch",
                    name = "Launch file",
                    showDebugOutput = true,
                    pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
                    pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
                    trace = true,
                    file = "${file}",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    pathCat = "cat",
                    pathBash = "bash",
                    pathMkfifo = "mkfifo",
                    pathPkill = "pkill",
                    args = {},
                    env = {},
                    terminalKind = "integrated",
                }
            }

            -- Automatically open when a debug session is created ─────────────────────────────────
            -- local dapui = require("dapui")
            -- dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            -- dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            -- dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

            -- Map q to quit in `nvim-dap-view` filetypes
            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
                callback = function(evt)
                    vim.keymap.set("n", "q", "<C-w>q", { silent = true, buffer = evt.buf })
                end,
            })
        end
    },
}
