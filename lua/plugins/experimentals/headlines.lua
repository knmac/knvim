-- Adds highlights for text filetypes, like markdown, org mode, and neorg
return {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        vim.cmd [[highlight Headline guibg=#494d64]]
        -- vim.cmd [[highlight Background guibg=#24273a]]
        vim.cmd [[highlight CodeBlock guibg=#1e2030]]
        vim.cmd [[highlight Dash guifg=#f5a97f]]

        local shared_opts = {
            headline_highlights = { "Headline", "ColorColumn", "" },
            dash_string = "━",
            fat_headlines = false,
        }

        require("headlines").setup({
            markdown = shared_opts,
            rmd = shared_opts,
            norg = shared_opts,
            org = shared_opts,
        })
    end,
}
