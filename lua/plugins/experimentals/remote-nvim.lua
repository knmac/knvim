return {
    "amitds1997/remote-nvim.nvim",
    version = "*",                       -- Pin to Github releases
    dependencies = {
        "nvim-lua/plenary.nvim",         -- For standard functions
        "MunifTanjim/nui.nvim",          -- To build the plugin UI
        "nvim-telescope/telescope.nvim", -- For picking b/w different remoted methods
    },
    config = function()
        require("remote-nvim").setup({
            remote = {
                app_name = "knvim",
                copy_dirs = {
                    config = {
                        base = vim.fn.stdpath("config"),
                        dirs = "*",
                        compression = {
                            enabled = true,
                            additional_opts = {}
                        },
                    },
                },
            },
            client_callback = function(port, workspace_config)
                local cmd = ("wezterm cli set-tab-title --pane-id $(wezterm cli spawn nvim --server localhost:%s --remote-ui) %s")
                    :format(
                        port,
                        ("'Remote: %s'"):format(workspace_config.host)
                    )
                if vim.env.TERM == "xterm-kitty" then
                    cmd = ("kitty -e nvim --server localhost:%s --remote-ui"):format(port)
                end
                vim.fn.jobstart(cmd, {
                    detach = true,
                    on_exit = function(job_id, exit_code, event_type)
                        -- This function will be called when the job exits
                        print("Client", job_id, "exited with code", exit_code, "Event type:",
                            event_type)
                    end,
                })
            end,
        })
    end,
}


-- -- Custom components using remote
-- local remote_stat = {
--     function()
--         return vim.g.remote_neovim_host and vim.uv.os_gethostname() or ""
--     end,
--     padding = { right = 1, left = 1 },
--     icon = "",
-- }
--
