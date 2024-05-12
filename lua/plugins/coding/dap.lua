-- Debug adapter protocol
local generate_python_launcher = function()
    local fname = ".vscode/launch.json"
    local f = io.open(fname, "r")
    if f ~= nil then
        io.close(f)
        return
    end

    local launch_content = [[
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

    require("os").execute("mkdir -p .vscode")
    local file, err = io.open(fname, "w")
    if file then
        file:write(launch_content)
        file:close()
        print(fname .. " generated")
    else
        print(err)
    end
end

return {
    "mfussenegger/nvim-dap", -- debug adapter protocol
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        {
            "rcarriga/nvim-dap-ui", -- UI for nvim-dap
            opts = {},
        },
        {
            "jay-babu/mason-nvim-dap.nvim", -- bridges mason.nvim and nvim-dap
            opts = {
                ensure_installed = { "python", "codelldb" },
                automatic_installation = true,
            },
        },
        {
            "LiadOz/nvim-dap-repl-highlights", -- syntax highlights to nvim-dap REPL
            dependencies = "nvim-treesitter/nvim-treesitter",
            build = ":TSInstall dap_repl",
            opts = {},
        },
    },
    keys = {
        { ",d", function() require("dapui").toggle() end,         desc = "DAP: Toggle UI" },
        { ",D", function() require("dap").repl.toggle() end,      desc = "DAP: Open default REPL" },
        { ",k", function() require("dap.ui.widgets").hover() end, desc = "DAP: Check variable value on hover" },
        {
            ",c",
            function()
                if vim.fn.filereadable(".vscode/launch.json") then
                    require("dap.ext.vscode").load_launchjs()
                end
                require("dap").continue()
            end,
            desc = "DAP: Start/Continue debugging",
        },
        { ",l", function() require("dap").run_last() end,          desc = "DAP: Run the last debug adapter entry" },
        { ",b", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
        {
            ",B",
            function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
            desc = "DAP: Toggle breakpoint with condition",
        },
        { ",n", function() require("dap").step_over() end, desc = "DAP: Step over" },
        { ",s", function() require("dap").step_into() end, desc = "DAP: Step into" },
        { ",u", function() require("dap").step_out() end,  desc = "DAP: Step out" },
        { ",t", function() require("dap").terminate() end, desc = "DAP: Terminate debugging" },
        -- { ",r", function() require("dap").run() end,       desc = "DAP: Run debugging" },
        { ",g", generate_python_launcher,                  desc = "DAP: generate launcher for Python" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -------------------------------------------------------------------------------------------
        -- Configurations for each languages
        -------------------------------------------------------------------------------------------
        -- Python - debugpy -----------------------------------------------------------------------
        dap.adapters.python = {
            type = "executable",
            command = vim.g.python3_host_prog,
            args = { "-m", "debugpy.adapter", },
        }
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

        -- C/C++ - codelldb -----------------------------------------------------------------------
        -- NOTE:your code has to be compiled first, e.g., using
        -- g++ -g main.cpp -o [output_name]
        -- Then provide [output_name] as the program name
        dap.adapters.lldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
                args = { "--port", "${port}" },
                -- On windows you may have to uncomment this:
                -- detached = false,
            }
        }
        dap.configurations.cpp = {
            {
                type = "lldb",
                request = "launch",
                name = "[Default] Launch DAP (codelldb) with file selection",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                console = "integratedTerminal",
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp

        -------------------------------------------------------------------------------------------
        -- Automatically open when a debug session is created
        -------------------------------------------------------------------------------------------
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

        -------------------------------------------------------------------------------------------
        -- Set up signs and colors
        -------------------------------------------------------------------------------------------
        vim.fn.sign_define("DapBreakpoint",
            { text = "🛑", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition",
            { text = "🔶", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
        vim.fn.sign_define("DapLogPoint",
            { text = "📜", texthl = "DapLogPoint", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped",
            { text = "👀", texthl = "", linehl = "debugPC", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected",
            { text = "🚫", texthl = "", linehl = "", numhl = "" })
    end
}
