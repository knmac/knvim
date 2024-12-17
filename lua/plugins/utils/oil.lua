-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
return {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "-", function() require("oil").toggle_float() end, desc = "Oil: toggle floating window" },
        { "_", function() require("oil").open() end,         desc = "Oil: open in the current buffer" },
    },
    opts = {},
}
