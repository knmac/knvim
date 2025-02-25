-- Generate docstring
return {
    "danymat/neogen",     -- generate docstring
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    -- event = "VeryLazy",
    keys = {
        { "<leader>d", "<CMD>Neogen<CR>", desc = "Neogen: Generate docstring" },
    },
    opts = {
        enabled = true,
        snippet_engine = "nvim",
    },
}
