-- Environment switcher
return {
    "AckslD/swenv.nvim",
    keys = {
        { "<space>e", function() require("swenv.api").pick_venv() end, desc = "Swenv: Switch python env" },
    },
    opts = {
        -- Should return a list of tables with a `name` and a `path` entry each.
        -- Gets the argument `venvs_path` set below.
        -- By default just lists the entries in `venvs_path`.
        get_venvs = function(venvs_path)
            return require("swenv.api").get_venvs(venvs_path)
        end,
        -- Path passed to `get_venvs`.
        venvs_path = vim.fn.expand("~/.venvs"),
        -- venvs_path = vim.fn.getcwd(),
        -- Something to do after setting an environment, for example call vim.cmd.LspRestart
        post_set_venv = function()
            vim.cmd.LspRestart()

            local current_env = require("swenv.api").get_current_venv()
            vim.g.python3_host_prog = current_env.path .. "/bin/python"

            vim.cmd[[Lazy reload nvim-dap]]
            vim.cmd[[Lazy reload nvim-dap-ui]]
        end,
        -- post_set_venv = nil,
    }
}
