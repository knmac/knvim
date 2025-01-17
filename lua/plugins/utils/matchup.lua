-- Highlight and navigate sets of matching text
return {
    "andymass/vim-matchup",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
        -- Treesitter integration
        require("nvim-treesitter.configs").setup({
            matchup = {
                enable = true,
                disable = { "bigfile" },
            },
        })
    end,
}
