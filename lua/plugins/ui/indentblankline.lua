-- Show indent lines
return {
    'lukas-reineke/indent-blankline.nvim', -- show indent line
    opts = {
        --char = '|',
        buftype_exclude = { 'terminal' },
        filetype_exclude = {
            'help', 'startify', 'make', 'NvimTree', 'neo-tree', 'neo-tree-popup',
            'dashboard', 'lsp-installer', 'alpha', 'packer', 'Outline', 'mason',
            'dap-float', 'lazy',
        },
        use_treesitter = true,
        show_current_context = true,
        show_current_context_start = false,
    },
}
