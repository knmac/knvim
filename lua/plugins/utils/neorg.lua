-- On MacOS, run `export CC="$(which gcc-12)"; nvim`
return {
    'nvim-neorg/neorg',
    dependencies = 'nvim-lua/plenary.nvim',
    build = ':Neorg sync-parsers', -- This is the important bit!
    opts = {
        load = {
            ['core.defaults'] = {},
            ['core.concealer'] = {},
            ['core.completion'] = {
                config = {
                    engine = 'nvim-cmp',
                },
            },
            ['core.dirman'] = {
                config = {
                    workspaces = {
                        work = '~/Documents/notes/work',
                        home = '~/Documents/notes/home',
                    }
                }
            },
            ['core.export'] = {},
        }
    },
}
