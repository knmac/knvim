-- Winbar component using lsp
return {
    {
        "Bekaboo/dropbar.nvim",
        event = "VeryLazy",
        keys = {
            { "<Leader>;", function() require("dropbar.api").pick() end,                desc = "Dropbar: Pick symbols in winbar" },
            { "[;",        function() require("dropbar.api").goto_context_start() end,  desc = "Dropbar: Go to start of current context" },
            { "];",        function() require("dropbar.api").select_next_context() end, desc = "Dropbar: Select next context" },
        },
        config = function()
            require("dropbar").setup({
                menu = {
                    win_configs = {
                        border = "rounded",
                    },
                },
            })
        end,
    },
}
