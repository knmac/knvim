-- A simple, easy-to-use Vim alignment plugin
return {
    {
        "junegunn/vim-easy-align",
        keys = {
            -- Start interactive EasyAlign in visual mode (e.g. vip\a)
            { "<leader>a", "<Plug>(EasyAlign)", mode = "x", desc = "EasyAlign: Start interactive EasyAlign in visual mode" },
            -- Start interactive EasyAlign for a motion/text object (e.g. \aip)
            { "<leader>a", "<Plug>(EasyAlign)", mode = "n", desc = "EasyAlign: Start interactive EasyAlign for a motion/text object" },
        },
    },
}
