-- Environment switcher
-- Change this to include your own python environments
local custom_python_envs = {
    { base_path = vim.fn.expand("~/.venvs"), source = "venvs", },
}

-- Wrapper to get environment from a base path
local get_venvs_wrapper = function(base_path, source, opts)
    local venvs = {}
    if base_path == nil then
        return venvs
    end
    local paths = require("plenary.scandir").scan_dir(
        base_path,
        vim.tbl_extend(
            "force",
            { depth = 1, only_dirs = true, silent = true },
            opts or {}
        )
    )
    for _, path in ipairs(paths) do
        table.insert(venvs, {
            name = require("plenary.path"):new(path):make_relative(base_path),
            path = path,
            source = source,
        })
    end
    return venvs
end

return {
    "AckslD/swenv.nvim",
    keys = {
        { "<space>e", function() require("swenv.api").pick_venv() end, desc = "Swenv: Switch python env" },
    },
    opts = {
        -- Should return a list of tables with a `name` and a `path` entry each.
        -- Gets the argument `venvs_path` set below.
        -- By default just lists the entries in `venvs_path`.
        -- get_venvs = function(venvs_path)
        --     return require("swenv.api").get_venvs(venvs_path)
        -- end,
        get_venvs = function()
            -- Default paths from environments
            local venvs = require("swenv.api").get_venvs()

            -- Loop through the paths in custom_python_envs and expand
            for _, path in ipairs(custom_python_envs) do
                vim.list_extend(venvs, get_venvs_wrapper(path["base_path"], path["source"]))
            end
            return venvs
        end,
        -- Path passed to `get_venvs`.
        -- venvs_path = vim.fn.getcwd(),
        venvs_path = nil,
        -- Something to do after setting an environment, for example call vim.cmd.LspRestart
        post_set_venv = function()
            -- Restart LSP
            vim.cmd.LspRestart()

            -- Reset python path in nvim
            local current_env = require("swenv.api").get_current_venv()
            vim.g.python3_host_prog = current_env.path .. "/bin/python"

            -- Restart DAP with new python path
            -- vim.cmd [[Lazy reload nvim-dap]]
            -- vim.cmd [[Lazy reload nvim-dap-ui]]
            require("lazy.core.loader").reload("nvim-dap")
            require("lazy.core.loader").reload("nvim-dap-ui")

            vim.notify("Switched env to: " .. current_env.name .. " [" .. current_env.source .. "]")
        end,
        -- post_set_venv = nil,
    }
}
