-- Diffview and mergetool
-- May need to add the following config to ~/.gitconfig
-- [merge]
--     tool = nvim
-- [mergetool]
--     keepBackup = false
--     prompt = false
-- [mergetool "nvim"]
--     cmd = "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\" -c DiffviewOpen"
return {
    "sindrets/diffview.nvim",
    event = { "BufReadPre", "BufNewFile" },
    -- event = "VeryLazy",
    keys = {
        {
            "<leader>v",
            function()
                if next(require("diffview.lib").views) == nil then
                    vim.cmd("DiffviewOpen")
                else
                    vim.cmd("DiffviewClose")
                end
            end,
            desc = "Diffview: Toggle"
        },
    },
    opts = {
        view = {
            merge_tool = {
                -- layout = "diff3_mixed",
                layout = "diff3_horizontal",
            },
        }
    },
}
