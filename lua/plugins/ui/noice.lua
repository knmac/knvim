-- UI improvement for messages, cmdline, and popupmenu

-- Scroll for lsp docs and signature helps
-- vim.keymap.set({ "n", "i", "s" }, "<c-j>", function()
--     if not require("noice.lsp").scroll(4) then
--         return "<c-j>"
--     end
-- end, { silent = true, expr = true })
--
-- vim.keymap.set({ "n", "i", "s" }, "<c-k>", function()
--     if not require("noice.lsp").scroll(-4) then
--         return "<c-k>"
--     end
-- end, { silent = true, expr = true })

return {
    {
        -- Noice
        "folke/noice.nvim",
        dependencies = "MunifTanjim/nui.nvim", -- UI Component Library for Neovim
        opts = {
            -- Turn off cmdline, messages, popupmenu, and notify for the default behavior
            -- cmdline = { enabled = false, },
            -- messages = { enabled = false, },
            -- popupmenu = { enabled = false, },
            -- notify = { enabled = false, },
            -- Setup LSP for prettier rendering
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = false, -- requires hrsh7th/nvim-cmp
                },
                progress = { enabled = false, },
                -- progress = { enabled = true, },
                hover = { enabled = true, },
                -- signature = { enabled = false, },
                signature = { enabled = true, },
                message = { enabled = true, },
            },
            messages = {
                enabled = true,
                view_search = false,
            },
            routes = {
                {
                    -- Skip all lsp progress contain the word 'Checking document'
                    filter = { event = "lsp", kind = "progress", find = "Checking document", },
                    skip = true,
                },
                {
                    -- Skip obsidian notification about conceallevel
                    filter = { find = "Obsidian additional syntax features require 'conceallevel' to be set to 1 or 2", },
                    skip = true,
                },
                { filter = { find = "E162" },                                   view = "mini" },
                { filter = { event = "msg_show", kind = "", find = "written" }, view = "mini" },
                { filter = { event = "msg_show", find = "search hit BOTTOM" },  skip = true },
                { filter = { event = "msg_show", find = "search hit TOP" },     skip = true },
                { filter = { event = "emsg", find = "E23" },                    skip = true },
                { filter = { event = "emsg", find = "E20" },                    skip = true },
                { filter = { find = "No signature help" },                      skip = true },
                { filter = { find = "E37" },                                    skip = true },
            },
            presets = {
                lsp_doc_border = true,
            },
            markdown = {
                highlights = {
                    ["^%s*(Args:)"] = "@text.title",
                    ["^%s*(Returns:)"] = "@text.title",
                    ["^%s*(Raises:)"] = "@text.title",
                    ["^%s*(Usage:)"] = "@text.title",
                    ["^%s*(Usages:)"] = "@text.title",
                    ["^%s*(Example:)"] = "@text.title",
                    ["^%s*(Examples:)"] = "@text.title",
                    -- ["^%S*:"] = "@parameter",
                    -- optional leading tabs or spaces -> non-whitespace word -> optional spaces before colon -> : -> non-whitespace after :
                    ["^[%s\t]*(%S+)%s*:%s*%S"] = "@parameter",
                },
            }
        },
    },
}
