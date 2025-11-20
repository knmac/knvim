-- Improved UI and workflow for the Neovim quickfix
return {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {
        keys = {
            {
                ">",
                function()
                    require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                end,
                desc = "Quicker: Expand quickfix context",
            },
            {
                "<",
                function()
                    require("quicker").collapse()
                end,
                desc = "Quicker: Collapse quickfix context",
            },
        },
    },
}
