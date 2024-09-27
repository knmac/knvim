-- Code tester
return {
    "nvim-neotest/neotest",
    event = "VeryLazy",
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
            event = "VeryLazy",
        },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                }),
            },
        })
    end,
}
