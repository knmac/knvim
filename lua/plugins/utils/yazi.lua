return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>y", "<cmd>Yazi<cr>",        desc = "Yazi: Open yazi at the current file", },
        { "<leader>Y", "<cmd>Yazi toggle<cr>", desc = "Yazi: Resume the last yazi session", },
    },
    opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = false,

        -- enable these if you are using the latest version of yazi
        use_ya_for_events_reading = true,
        use_yazi_client_id_flag = true,

        keymaps = {
            show_help = "<f1>",
        },
    },
}
