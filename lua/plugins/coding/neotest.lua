-- Code tester
return {
    "nvim-neotest/neotest",
    event = { "BufReadPre", "BufNewFile" },
    -- event = "VeryLazy",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            event = "VeryLazy",
        },
        {
            "nvim-neotest/nvim-nio",
            event = "VeryLazy",
        },
        {
            "nvim-neotest/neotest-python",
            event = { "BufReadPre", "BufNewFile" },
            -- event = "VeryLazy",
        },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                }),
            },
            floating = {
                border = "rounded",
            },
        })
    end,
}
