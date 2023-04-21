-- Code parser generator for syntax highlighting
return {
    'nvim-treesitter/nvim-treesitter', -- code parser generator for syntax highlighting
    dependencies = 'HiPhish/nvim-ts-rainbow2',  -- colorize parentheses
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
                -- disable = {},
                disable = function(_, bufnr) -- Disable in large buffers
                    return vim.api.nvim_buf_line_count(bufnr) > 50000
                end,
            },
            indent = {
                enable = false,  -- treesitter's indent is buggy
                disable = {},
            },
            ensure_installed = {
                'python',
                'c',
                'cpp',
                'bash',
                'latex',
                'bibtex',
                'markdown',
                'markdown_inline',
                'json',
                'yaml',
                'html',
                'css',
                'lua',
                'cmake',
                'dockerfile',
                'regex',
                'sql',
                'vim',
            },
            matchup = {
                enable = true,
            },
            rainbow = {
                enable = true,
                -- list of languages you want to disable the plugin for
                -- disable = { 'jsx', 'cpp' },
                -- Which query to use for finding delimiters
                query = 'rainbow-parens',
                -- Highlight the entire buffer all at once
                strategy = require('ts-rainbow.strategy.global'),
            }
        })

        -- Overwrite fold method using treesitter expression
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
}
