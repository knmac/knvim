-- General-purpose motion plugin for Neovim
return {
    'ggandor/leap.nvim',
    dependencies = 'tpope/vim-repeat',  -- for dot-repeats (.) to work as intended
    config = function()
        require('leap').add_default_mappings()
    end,
}
