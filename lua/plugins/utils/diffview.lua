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
    opts = {
        view = {
            merge_tool = {
                layout = "diff3_mixed",
            },
        }
    },
}
