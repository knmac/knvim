-- Displays a popup with possible key bindings
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Which-key: Buffer Local Keymaps",
        },
    },
    opts = {
        preset = "classic", -- classic | modern | helix
        delay = 200,
        win = {
            border = "rounded",
        },
    },
}
