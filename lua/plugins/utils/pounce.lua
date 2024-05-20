-- Fuzzy text jumping
return {
    "rlane/pounce.nvim",
    keys = {
        { "s",  function() require("pounce").pounce {} end,                   mode = "n", desc = "Pounce: start" },
        { "S",  function() require("pounce").pounce { do_repeat = true } end, mode = "n", desc = "Pounce: repeat last entered text" },
        { "s",  function() require("pounce").pounce {} end,                   mode = "x", desc = "Pounce: start" },
        { "gs", function() require("pounce").pounce {} end,                   mode = "o", desc = "Pounce: start in vim-surround" },
        -- { "S",  function() require("pounce").pounce { input = { reg = "/" } } end, mode = "n" },
    },
}
