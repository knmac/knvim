-- Code commenter
return {
    "numToStr/Comment.nvim", -- code commenter
    opts = {
        ---Add a space b/w comment and the line
        ---@type boolean
        padding = true,
        ---Whether the cursor should stay at its position
        ---This only affects NORMAL mode mappings and doesn't work with dot-repeat
        ---@type boolean
        sticky = true,
        ---Lines to be ignored while comment/uncomment.
        ---Could be a regex string or a function that returns a regex string.
        ---Example: Use '^$' to ignore empty lines
        ---@type string|function
        ignore = "^$",
        ---LHS of toggle mappings in NORMAL + VISUAL mode
        ---@type table
        toggler = {
            ---line-comment keymap
            line = "gcc",
            ---block-comment keymap
            block = "gbc",
        },
        ---LHS of operator-pending mappings in NORMAL + VISUAL mode
        ---@type table
        opleader = {
            ---line-comment keymap
            line = "gc",
            ---block-comment keymap
            block = "gb",
        },
        ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
        ---@type table
        mappings = {
            ---operator-pending mapping
            ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
            ---These mappings can be changed individually by `opleader` and `toggler` config
            basic = true,
            ---extra mapping
            ---Includes `gco`, `gcO`, `gcA`
            extra = true,
            ---extended mapping
            ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
            extended = false,
        },
        ---Pre-hook, called before commenting the line
        ---@type function
        pre_hook = nil,
        ---Post-hook, called after commenting is done
        ---@type function
        post_hook = nil,
    },
}
