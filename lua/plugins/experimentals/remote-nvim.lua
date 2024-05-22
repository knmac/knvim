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
                copy_dirs = {
                    -- What to copy to remote's Neovim config directory
                    config = {
                        -- TODO: this is buggy because knvim config is ~/.config/knvim. But this
                        -- will copy to ~/.remote-nvim/workspaces/[workspace_name]/.config/knvim and
                        -- use the config from
                        -- ~/.remote-nvim/workspaces/[workspace_name]/.confg/nvim, so we need to
                        -- manually link the 2 folders on remote side. Futhermore, it will copy
                        -- everything from .git/ folder, which is not necessary.
                        -- Solution: (1) specify source and target dir, and (2) allow ignore
                        -- files/dirs
                        base = vim.fn.stdpath("config"),     -- Path from where data has to be copied
                        dirs = { "*" }, -- Directories that should be copied over. "*" means all directories. To specify a subset, use a list like {"lazy", "mason"} where "lazy", "mason" are subdirectories
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
