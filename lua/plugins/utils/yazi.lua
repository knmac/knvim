-- Intergrate Yazi to nvim better than open it in a pop-up terminal
return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
        -- { "<leader>-", "<cmd>Yazi<cr>", desc = "Open yazi at the current file", mode = { "n", "v" } },
        -- { "<leader>cw", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory", },
        { "_", "<cmd>Yazi toggle<cr>", desc = "Yazi: Resume the last yazi session", },
    },
    opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = false,
        keymaps = { show_help = "<f1>", },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    -- init = function()
    --     -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    --     vim.g.loaded_netrwPlugin = 1
    -- end,
}
