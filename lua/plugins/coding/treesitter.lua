-- Code parser generator for syntax highlighting
return {
    'nvim-treesitter/nvim-treesitter',                -- code parser generator for syntax highlighting
    dependencies = 'HiPhish/rainbow-delimiters.nvim', -- colorize parentheses
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
                -- disable = {},
                disable = function(_, bufnr)
                    if vim.api.nvim_buf_line_count(bufnr) > 50000 then
                        -- Disable in large number of line
                        return true
                    end

                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
                    if ok and stats and stats.size > 100 * 1024 then
                        -- Disable in large buffer size
                        return true
                    end
                end,
            },
            indent = {
                enable = false, -- treesitter's indent is buggy
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
                'javascript',
                'typescript',
                'scala',
                'dap_repl',
            },
            matchup = {
                enable = true,
            },
        })

        -- Overwrite fold method using treesitter expression
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

        -- Rainbow delimiters config
        local rainbow_delimiters = require 'rainbow-delimiters'

        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = rainbow_delimiters.strategy['global'],
                vim = rainbow_delimiters.strategy['local'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        }
    end,
}
