-- Extra utils without needing to config
return {
    -- Lua nvim plugins ---------------------------------------------------------------------------
    {
        "rlane/pounce.nvim", -- fuzzy text jumping
        keys = {
            { "s",  "<CMD>Pounce<CR>",       mode = "n", desc = "Pounce: start pounce mode" },
            { "s",  "<CMD>Pounce<CR>",       mode = "x", desc = "Pounce: start pounce mode" },
            { "S",  "<CMD>PounceRepeat<CR>", mode = "n", desc = "Pounce: start pounce mode using the last entered text" },
            { "gs", "<CMD>Pounce<CR>",       mode = "o", desc = "Pounce: start pounce mode in vim-surround" },
        },
    },
    "norcalli/nvim-colorizer.lua", -- colorize color code
    -- Non-lua nvim plugins -----------------------------------------------------------------------
    {
        "junegunn/vim-easy-align", -- alignment plugin
        keys = {
            -- Start interactive EasyAlign in visual mode (e.g. vip\a)
            { "<leader>a", "<Plug>(EasyAlign)", mode = "x", desc = "EasyAlign: start interactive EasyAlign in visual mode" },
            -- Start interactive EasyAlign for a motion/text object (e.g. \aip)
            { "<leader>a", "<Plug>(EasyAlign)", mode = "n", desc = "EasyAlign: start interactive EasyAlign for a motion/text object" },
        },
    },
    -- 'fladson/vim-kitty',           -- syntax highlighting for kitty
}
