-- Diffview and mergetool
-- Extra setup
-- Git merge tool
-- git config --global merge.tool codediff
-- git config --global mergetool.codediff.cmd 'nvim "$MERGED" -c "CodeDiff merge \"$MERGED\""'
--
-- Git diff tool
-- git config --global diff.tool codediff
-- git config --global difftool.codediff.cmd 'nvim "$LOCAL" "$REMOTE" +"CodeDiff file $LOCAL $REMOTE"'

return {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
}
