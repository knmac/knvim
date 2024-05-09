-- Code commenter
return {
    "numToStr/Comment.nvim", -- code commenter
    keys = {
        {
            "<C-/>",
            function() require("Comment.api").toggle.linewise.current() end,
            desc = "Comment: toggle current line"
        },
    },
    lazy = false,
    opts = {},
}
