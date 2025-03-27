-- Session manager
return {
    "Shatur/neovim-session-manager",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            event = "VeryLazy",
        },
    },
    event = "BufEnter",
    keys = {
        { "<space>s", "<CMD>SessionManager<CR>", desc = "SessionManager: Open" },
    },
    config = function()
        local Path = require("plenary.path")
        local config = require("session_manager.config")
        require("session_manager").setup({
            sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
            autoload_mode = config.AutoloadMode.Disabled,
            autosave_last_session = true,
            autosave_ignore_not_normal = true,
            autosave_ignore_dirs = {},
            autosave_ignore_filetypes = {
                "gitcommit",
                "gitrebase",
                "toggleterm",
                "neo-tree",
                "Outline",
            },
            autosave_ignore_buftypes = {
                "toggleterm",
                "neo-tree",
                "Outline",
            },
            autosave_only_in_session = true,
            max_path_length = 75,
        })

        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "SessionLoadPost",
            group = vim.api.nvim_create_augroup("SessionGroup", {}),
            callback = function()
                vim.cmd [[Lazy reload colorful-winsep.nvim]]
            end,
        })
    end,
}
