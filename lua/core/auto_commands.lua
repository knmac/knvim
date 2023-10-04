-------------------------------------------------------------------------------
-- Auto-commands for NeoVim
-------------------------------------------------------------------------------
local default_opts = { noremap = true, silent = true }

-------------------------------------------------------------------------------
-- Auto change the configs
-------------------------------------------------------------------------------
local user_cfgs_group = vim.api.nvim_create_augroup('user_cfgs', { clear = false })

-- Only show cursorline in active windows
vim.api.nvim_create_autocmd('WinEnter', {
    group = user_cfgs_group,
    callback = function() vim.opt_local.cursorline = true end,
})
vim.api.nvim_create_autocmd('WinLeave', {
    group = user_cfgs_group,
    callback = function() vim.opt_local.cursorline = false end,
})

-- Make sure colons do not mess up the indent in Python
vim.cmd [[
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:
]]

-- Use tab instead of space for make files
vim.api.nvim_create_autocmd('FileType', {
    desc = 'Use tab instead of space for make files',
    pattern = { 'make' },
    group = user_cfgs_group,
    callback = function() vim.opt_local.expandtab = false end,
})

-- 2 spaces for these file types
vim.api.nvim_create_autocmd('FileType', {
    desc = '2 spaces for these files types',
    -- pattern = { 'xml', 'html', 'c', 'cpp', 'h', 'hpp' },
    pattern = { 'xml', 'yaml', 'json', 'html', 'css', 'typescript', 'scala' },
    group = user_cfgs_group,
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- Go down/up soft-wrapped lines instead of 'real' lines
vim.api.nvim_create_autocmd('FileType', {
    desc = 'Go down/up soft-wrapped lines instead of real lines',
    pattern = { 'md', 'markdown', 'tex', },
    group = user_cfgs_group,
    callback = function()
        vim.keymap.set('n', 'j', 'gj', default_opts)
        vim.keymap.set('n', 'k', 'gk', default_opts)
    end,
})

-------------------------------------------------------------------------------
-- Callable commands
-------------------------------------------------------------------------------
local user_cmds_group = vim.api.nvim_create_augroup('user_cmds', { clear = false })

-- Shortcut for Python breakpoint (ipdb)
vim.api.nvim_create_autocmd('FileType', {
    desc = 'Insert breakpoints for python files',
    pattern = { 'python' },
    group = user_cmds_group,
    callback = function()
        vim.keymap.set('n', '<leader>b', 'obreakpoint()<esc>', default_opts)
        vim.keymap.set('n', '<leader>B', 'Obreakpoint()<esc>', default_opts)
    end,
})

-- Clear registered macros
function ClearReg()
    vim.cmd [[
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
    ]]
    vim.notify('All registers cleared', vim.log.levels.INFO)
end
vim.api.nvim_create_user_command('ClearRegisters', function() ClearReg() end, {})

-- Toggle zoom the current window
-- vim.cmd [[
-- function! ToggleZoom(zoom)
--     if exists("t:restore_zoom") && (a:zoom == v:true || t:restore_zoom.win != winnr())
--         exec t:restore_zoom.cmd
--         unlet t:restore_zoom
--     elseif a:zoom
--         let t:restore_zoom = { 'win': winnr(), 'cmd': winrestcmd() }
--         exec "normal \<C-W>\|\<C-W>_"
--     endif
-- endfunction

-- augroup restorezoom
--     au WinEnter * silent! :call ToggleZoom(v:false)
-- augroup END
-- ]]

-- Fill the rest of line with characters
-- TODO: change to lua implementation
vim.cmd [[
function! FillLine( str )
    " set tw to the desired total length
    let tw = &textwidth
    if tw==0 | let tw = 79 | endif
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction
]]
-- Fill with '-' characters
vim.keymap.set('n', '<leader>-', ':call FillLine("-")<CR>', default_opts)
-- Fill with '=' characters
vim.keymap.set('n', '<leader>=', ':call FillLine("=")<CR>', default_opts)
