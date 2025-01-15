-- Fuzzy finder for multiple things
return {
    "nvim-telescope/telescope.nvim", -- fuzzy finder for multiple things
    event = "VeryLazy",
    dependencies = {
        { "nvim-telescope/telescope-ui-select.nvim", event = "VeryLazy" },
        {
            "nvim-telescope/telescope-bibtex.nvim", -- fuzzy finder for bibtex entries
            event = "VeryLazy",
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim", -- use fzf sorter for telescope
            event = "VeryLazy",
            build = "make",
        },
    },
    -- keys = {
    --     { "<space><space>", "<CMD>Telescope<CR>",                           desc = "Telescope: Open builtin" },
    --     { "<space>f",       "<CMD>Telescope find_files<CR>",                desc = "Telescope: Find files" },
    --     { "<space>t",       "<CMD>Telescope live_grep<CR>",                 desc = "Telescope: Find text" },
    --     { "<space>b",       "<CMD>Telescope buffers<CR>",                   desc = "Telescope: Find buffer" },
    --     { "<space>/",       "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope: Find in buffer" },
    --     { "<space>c",       "<CMD>Telescope bibtex<CR>",                    desc = "Telescope: Find bibtex" },
    --     { "<space>v",       "<CMD>Telescope vim_options<CR>",               desc = "Telescope: Find vim option" },
    --     { "<space>h",       "<CMD>Telescope help_tags<CR>",                 desc = "Telescope: Find help" },
    --     { "<space>k",       "<CMD>Telescope keymaps<CR>",                   desc = "Telescope: Find key map" },
    --     { "<space>?",       "<CMD>Telescope commands<CR>",                  desc = "Telescope: Find command" },
    --     -- { "<space>n",       "<CMD>Telescope notify<CR>",                    desc = "Telescope: Find notification" },
    --     { "<space>m",       "<CMD>Telescope marks<CR>",                     desc = "Telescope: Find marks" },
    -- },
    config = function()
        local actions = require("telescope.actions")

        require("telescope").setup({
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        -- ['<C-h>'] = 'which_key'
                        ["<C-h>"] = actions.which_key,
                        ["<C-j>"] = actions.preview_scrolling_down,
                        ["<C-k>"] = actions.preview_scrolling_up,
                        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                    n = {
                        -- ["<C-h>"] = actions.which_key,
                        ["<C-j>"] = actions.preview_scrolling_down,
                        ["<C-k>"] = actions.preview_scrolling_up,
                        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                        -- even more opts
                    }
                },
                ["fzf"] = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                ["bibtex"] = {
                    -- Path to global bibliographies (placed outside of the project)
                    -- global_files = {
                    --     os.getenv("HOME") .. "/Documents/global.bib",
                    -- },
                    -- Use context awareness
                    context = true,
                    -- Use non-contextual behavior if no context found
                    -- This setting has no effect if context = false
                    context_fallback = true,
                    citation_format = "{{author}} {{title}}. {{booktitle}}{{journal}}. {{year}}.",
                },
                ["persisted"] = {
                    layout_config = { width = 0.55, height = 0.55 }
                }
            }
        })

        -- Load other telescope extensions
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("bibtex")
        -- require("telescope").load_extension("notify")
        require("telescope").load_extension("persisted")

        -- Wrap lines in previewer
        vim.api.nvim_create_autocmd("User", {
            pattern = "TelescopePreviewerLoaded",
            callback = function(_)
                vim.wo.wrap = true
            end,
        })
    end,
}
