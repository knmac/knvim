-- Writing and navigating an Obsidian vault
return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        keys = {
            {
                "<leader>m",
                function()
                    if vim.bo.filetype == "markdown" then
                        vim.cmd [[Markview]]
                    end
                end,
                desc = "Markview: Toggle rendering"
            },
        },
        init = function()
            local presets = require("markview.presets")
            require("markview").setup({
                preview = { enable = false },
                markdown = {
                    tables = presets.tables.rounded,
                },
                markdown_inline = {
                    checkboxes = {
                        checked = { text = "", hl = "MarkviewCheckboxChecked", scope_hl = "MarkviewCheckboxChecked" },
                        unchecked = { text = "󰄱", hl = "MarkviewCheckboxUnchecked", scope_hl = "@text" },
                        -- [">"] = { text = "󰏭", hl = "MarkviewCheckboxProgress", scope_hl = "MarkviewCheckboxProgress" },
                        -- ["~"] = { text = "󱋭", hl = "MarkviewCheckboxCancelled", scope_hl = "MarkviewCheckboxStriked" },
                        -- ["!"] = { text = "󰀦", hl = "MarkviewCheckboxUnchecked", scope_hl = "MarkviewCheckboxUnchecked" },
                    },
                },
            })
        end
    },
}
