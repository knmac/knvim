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
    keys = {
        { ";s",  function() require("neotest").summary.toggle() end,                                  desc = "Neotest: Toggle summary" },
        { ";k",  function() require("neotest").output.open({ enter = true }) end,                     desc = "Neotest: Open output" },
        { ";o",  function() require("neotest").output_panel.toggle() end,                             desc = "Neotest: Toggle output-panel" },
        { ";rr", function() require("neotest").run.run() end,                                         desc = "Neotest: Run the nearest test" },
        { ";rf", function() require("neotest").run.run(vim.fn.expand("%")) end,                       desc = "Neotest: Run the current file" },
        { ";rd", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, desc = "Neotest: Run the current file with nvim-dap" },
        { ";ll", function() require("neotest").run.run_last() end,                                    desc = "Neotest: Run the last test" },
        { ";ld", function() require("neotest").run.run_last({ strategy = "dap" }) end,                desc = "Neotest: Run the last test but debug with nvim-dap" },
        { ";t",  function() require("neotest").run.stop() end,                                        desc = "Neotest: Stop a running process" },
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
