-- Fuzzy text jumping
return {
    dependency = { "tpope/vim-repeat" },
    "ggandor/leap.nvim",
    config = function()
        require("leap").create_default_mappings()
    end,
}
