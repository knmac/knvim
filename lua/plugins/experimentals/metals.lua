-- Nvim-metals for scala development (cannot be used with lsp-config)
-- TODO: highly experimental, needs to cleanup
return {
    'scalameta/nvim-metals',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
        local metals_config = require('metals').bare_config()

        -- Example of settings
        metals_config.settings = {
            showImplicitArguments = true,
            -- excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
        }

        -- *READ THIS*
        -- I *highly* recommend setting statusBarProvider to true, however if you do,
        -- you *have* to have a setting to display this in your statusline or else
        -- you'll not see any messages from metals. There is more info in the help
        -- docs about this
        -- metals_config.init_options.statusBarProvider = "on"

        -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
        metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Debug settings if you're using nvim-dap
        local dap = require("dap")

        dap.configurations.scala = {
            {
                type = "scala",
                request = "launch",
                name = "RunOrTest",
                metals = {
                    runType = "runOrTestFile",
                    --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                },
            },
            {
                type = "scala",
                request = "launch",
                name = "Test Target",
                metals = {
                    runType = "testTarget",
                },
            },
        }

        -- On attach
        local telescope = require('telescope.builtin')
        local bufmap = function(mode, lhs, rhs, bufnr, desc)
            local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = 'LSP: ' .. desc }
            vim.keymap.set(mode, lhs, rhs, bufopts)
        end

        metals_config.on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings
            bufmap('n', 'gd', telescope.lsp_definitions, bufnr, 'Go to definition')
            bufmap('n', 'gi', telescope.lsp_implementations, bufnr, 'Go to implementation')
            bufmap('n', 'gr', telescope.lsp_references, bufnr, 'Go to references')
            bufmap('n', 'gt', telescope.lsp_type_definitions, bufnr, 'Go to type definition')

            bufmap('n', 'gD', vim.lsp.buf.declaration, bufnr, 'Go to declaration')
            bufmap('n', 'K', vim.lsp.buf.hover, bufnr, 'Show docstring of the item under the cursor')
            bufmap('i', '<C-k>', vim.lsp.buf.signature_help, bufnr, 'Show signature help')

            bufmap('n', '<leader>rn', vim.lsp.buf.rename, bufnr, 'Rename variable under the cursor')
            bufmap('n', '<leader>ca', vim.lsp.buf.code_action, bufnr, 'Code action')
            bufmap('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, bufnr, 'Format the buffer')

            bufmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufnr, 'Add workspace')
            bufmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufnr, 'Remove workspace')
            bufmap('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufnr, 'List workspaces')

            -- Enable vim-navic
            require('nvim-navic').attach(client, bufnr)

            require("metals").setup_dap()
        end

        -- Autocmd that will actually be in charging of starting the whole thing
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            -- NOTE: You may or may not want java included here. You will need it if you
            -- want basic Java support but it may also conflict if you are using
            -- something like nvim-jdtls which also works on a java filetype autocmd.
            pattern = { "scala", "sbt", "java" },
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end,
}
