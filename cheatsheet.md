---
id: cheatsheet
aliases: []
tags: []
---

# Knvim cheatsheet

(The default `<leader>` is `\`)

## 1. Custom key-bindings

### 1.1. Fn key-bindings

Overall logic:

- `F1-4`: toggle things
- `F5-6`: buffers/tabs
- `F9-12`: random frequently used things

| Group                 | Functionality                            | Key-binding                  |
| --------------------- | ---------------------------------------- | ---------------------------- |
| `F1-4`: toggle things | Search for help                          | `F1` (or `<space> h`)        |
|                       | Rename variables                         | `F2` (or `<leader> rn`)      |
|                       | Toggle file explorer                     | `F3` (or `<leader> t`)       |
|                       | Toggle symbol view                       | `F4` (or `<leader> o`)       |
|                       | Show key-bindings                        | `Shift+F1` (or `<space> k`)  |
|                       | Open to-do list (project-wise)           | `Shift+F2`                   |
|                       | Open diagnostic list (project-wise)      | `Shift+F4` (or `<space> d`)  |
| `F5-8`: buffers/tabs  | Show buffer list                         | `F5` (or `<space> b`)        |
|                       | Previous buffer                          | `F6` (or `Ctrl+Alt+h`)       |
|                       | Next buffer                              | `F7` (or `Ctrl+Alt+l`)       |
|                       | Close the current buffer                 | `F8` (or `Ctrl+Alt+Shift+k`) |
|                       | Show tab list                            | `Shift+F5`                   |
|                       | Previous tab                             | `Shift+F6`                   |
|                       | Next tab                                 | `Shift+F7`                   |
|                       | Close the current tab                    | `Shift+F8`                   |
| `F9-12`: others       | Quick format the current file            | `F9`                         |
|                       | Run the `make` command                   | `F10`                        |
|                       | Toggle zoom the current window (splits)  | `F11` (or `<leader> z`)      |
|                       | Toggle relative number                   | `F12`                        |
|                       | Run the `make clean` command             | `Shift+F10`                  |
|                       | Toggle color code colorizing (e.g., CSS) | `Shift+F11`                  |
|                       | Toggle welcome screen                    | `Shift+F12`                  |

### 1.2. Custom commands

Overall logic:

- All commands start with `Knvim` prefix

| Command                        | Functionality                                                          |
| ------------------------------ | ---------------------------------------------------------------------- |
| `:KnvimClearMarks`             | Clear all bookmarks                                                    |
| `:KnvimClearRegisters`         | Clear all registers                                                    |
| `:KnvimFillLine <character>`   | Fill the current line with `<character>`                               |
| `:KnvimQuickFormat`            | Remove trailing spaces and format smart single ‘’ and double “” quotes |
| `:KnvimTermVert`               | Toggle vertical terminal                                               |
| `:KnvimToggleClickableLualine` | Toggle clicability of statusline                                       |

### 1.3. Snacks key-bindings

#### 1.3.1 Snacks.picker (fuzzy finder) key-bindings

All picker key-bindings start with `<space>`.

| Functionality                     | Key-binding       |
| --------------------------------- | ----------------- |
| Open Snacks picker                | `<space> <space>` |
| Find *f*iles                      | `<space> f`       |
| Find *t*ext (grep)                | `<space> t`       |
| Find *b*uffer                     | `<space> b`       |
| Find *h*elp                       | `<space> h`       |
| Find *k*eymap                     | `<space> k`       |
| Find *c*ommands                   | `<space> c`       |
| Find *m*arks                      | `<space> m`       |
| Find *r*egisters                  | `<space> r`       |
| Find *d*iagnostics                | `<space> d`       |
| Find in *j*ndo tree               | `<space> j`       |
| Find in *u*ndo tree               | `<space> u`       |
| Find spelling                     | `<space> z`       |
| Find hovered word                 | `<space> *`       |
| Find in open buffers              | `<space> /`       |
| Find python virtual *e*nvironment | `<space> e`       |
| Find *s*ession                    | `<space> s`       |
| Delete session                    | `<space> S`       |

Inside the picker:

| Functionality               | Key-binding (insert mode) | Key-binding (normal mode) |
| --------------------------- | ------------------------- | ------------------------- |
| Go to the next line         | `Ctrl+n`                  | `j`                       |
| Go to the previous line     | `Ctrl+p`                  | `k`                       |
| Scroll down the doc         | `Ctrl+b`                  | `Ctrl+b`                  |
| Scroll up the doc           | `Ctrl+f`                  | `Ctrl+f`                  |
| Select multiple items       | `Tab`                     | `Tab`                     |
| Send selection to quicklist | `Ctrl+q`                  | `Ctrl+q`                  |
| Close                       | `Ctrl+c`                  | `Esc`                     |
| Show help (which-key)       | -                         | `?`                       |

For the complete key-bindings, see Snacks picker's [doc](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md).

#### 1.3.2. Other Snacks key-bindings

| Functionality                         | Key-binding  |
| ------------------------------------- | ------------ |
| Toggle Zen-mode                       | `<leader> z` |
| Toggle zoom of the current window     | `<leader> Z` |
| Dismiss current notification message  | `<leader> n` |
| Show history of notification messages | `<leader> N` |
| Open Lazygit                          | `<leader> g` |
| Open scratch buffer                   | `<leader> s` |
| Select scratch buffer                 | `<leader> S` |
| Toggle terminal                       | `Ctrl+\`     |
| Enter normal mode in terminal         | `<Esc><Esc>` |
| Open Yazi                             | `Ctrl+y`     |

### 1.4. LSP key-bindings

| Group       | Functionality                                         | Key-binding                   |
| ----------- | ----------------------------------------------------- | ----------------------------- |
| Navigation  | Go to *d*efinitions                                   | `gd`                          |
|             | Go to *f*ile path (not LSP, vim default)              | `gf`                          |
|             | Go to *f*ile path in a new vertical split             | `gF`                          |
|             | Go to t*y*pe definition                               | `gy`                          |
|             | Go to *r*eference                                     | `grr`                         |
|             | Go to *i*mplementation                                | `gri`                         |
| Misc        | Re*n*ame variables                                    | `grn`                         |
|             | Code *a*ction (if supported)                          | `gra`                         |
|             | Show function documentation (on hover)                | `K`                           |
|             | Show signature help (while typing function arguments) | `Ctrl+k`                      |
|             | Code formatting (if supported)                        | `<leader> f`                  |
|             | Toggle inlay-hint (if supported)                      | `<leader> i`                  |
| Diagnostics | Open *d*iagnostic list (project-wise)                 | `<space> d`                   |
|             | Show current line's diagnostics                       | `Ctrl+w d` or `Ctrl+w Ctrl+d` |
|             | Go to previous diagnostic                             | `[d`                          |
|             | Go to next diagnostic                                 | `]d`                          |

### 1.5. Window and buffer navigation

Overall logic:

- `Alt`: for split manipulation (with `Shift` to swap)
- `Ctrl+Alt`: for buffer manipulation (with `Shift` for extra functionalities)

| Group               | Functionality                 | Key-binding         |
| ------------------- | ----------------------------- | ------------------- |
| Split manipulation  | Switch to the left window     | `Alt+h`             |
|                     | Switch to the lower window    | `Alt+j`             |
|                     | Switch to the upper window    | `Alt+k`             |
|                     | Switch to the right window    | `Alt+l`             |
|                     | Swap with the left window     | `Alt+Shift+h`       |
|                     | Swap with the lower window    | `Alt+Shift+j`       |
|                     | Swap with the upper window    | `Alt+Shift+k`       |
|                     | Swap with the right window    | `Alt+Shift+l`       |
|                     | Decrease window width         | `Alt+Left`          |
|                     | Increase window width         | `Alt+Right`         |
|                     | Decrease window height        | `Alt+Down`          |
|                     | Increase window height        | `Alt+Up`            |
| Buffer manipulation | Switch to the previous buffer | `Ctrl+Alt+h`        |
|                     | Switch to the next buffer     | `Ctrl+Alt+l`        |
|                     | *J*ump to a buffer            | `Ctrl+Alt+j`        |
|                     | *K*ill a buffer               | `Ctrl+Alt+k`        |
|                     | Swap with the previous buffer | `Ctrl+Alt+Shift+h`  |
|                     | Swap with the next buffer     | `Ctrl+Alt+Shift+l`  |
|                     | Restore a closed buffer       | `Ctrl+Alt+Shift+j`  |
|                     | Kill the current buffer       | `Ctrl+Alt+Shift+k`  |
|                     | Pin/unpin the current buffer  | `Ctrl+Alt+p`        |
| Tab manipulation    | Switch to the next tab        | `Ctrl+Alt+PageDown` |
| (vim default)       | Switch to the previous tab    | `Ctrl+Alt+PageUp`   |

### 1.6. DAP key-bindings

All DAP key-bindings start with `,`.

| Functionality                                 | Key-binding |
| --------------------------------------------- | ----------- |
| Toggle DAP UI                                 | `,d`        |
| Toggle DAP breakpoint                         | `,b`        |
| Toggle DAP breakpoint with condition          | `,B`        |
| Continue DAP debugging                        | `,c`        |
| Run last DAP launcher (if there are many)     | `,l`        |
| Step over                                     | `,n`        |
| Step into                                     | `,s`        |
| Step out                                      | `,u`        |
| Terminate debugging                           | `,t`        |
| Hover variable while debugging                | `,k`        |
| Add the expression under cursor to watch list | `,w`        |
| Generate launcher template for python project | `,gp`       |

### 1.7. Neotest key-bindings

All Neotest key-bindings start with `;`.

| Functionality                             | Key-binding |
| ----------------------------------------- | ----------- |
| Toggle summary                            | `;s`        |
| Open output (hover)                       | `;k`        |
| Toggle output-panel                       | `;o`        |
| Run the nearest test                      | `;rr`       |
| Run the current file                      | `;rf`       |
| Run the current file with nvim-dap        | `;rd`       |
| Run the last test                         | `;ll`       |
| Run the last test but debug with nvim-dap | `;ld`       |
| Stop a running process                    | `;t`        |

### 1.8. Other custom key-bindings

| Group        | Functionality                                   | Key-binding          |
| ------------ | ----------------------------------------------- | -------------------- |
| Misc         | **Show local key-maps in the buffer**           | `<leader> ?`         |
|              | Insert python breakpoint (on the next line)     | `<leader> b`         |
|              | Insert python breakpoint (on the previous line) | `<leader> B`         |
|              | Fill line with `─` characters                   | `<leader> -`         |
|              | Fill line with `━` characters                   | `<leader> =`         |
|              | Generate doc string for function                | `<leader> d`         |
|              | Toggle file explorer                            | `<leader> e`         |
|              | Toggle outline view (on the screen right side)  | `<leader> o`         |
|              | Toggle outline view (beside current buffer)     | `<leader> O`         |
|              | Toggle Diffview                                 | `<leader> v`         |
|              | In insert mode, `Alt+h,j,k,l` becomes arrows    | `Alt+h,j,k,l`        |
| File Manager | Open Oil                                        | `_`                  |
| Git hunk     | Go to previous hunk of Git change               | `[c`                 |
|              | Go to next hunk of Git change                   | `]c`                 |
| Easy-align   | Start easy align (in visual mode)               | `<leader> a`         |
|              | - _Example:_ align by `\|`                      | `<leader> a*\|`      |
|              | - _Example:_ align by `<space>`                 | `<leader> a*<space>` |
| Neogen       | Generate docstring                              | `<leader> d`         |
| Markdown     | Toggle markdown render                          | `<leader> m`         |
|              | Cycle through checkbox marks                    | `Ctrl+<space>`       |
| Sidekick     | Toggle sidekick (AI Agent)                      | `Ctrl+.`             |

## 2. Clickable Lualine

Lualine components are configured so that most of them are clickable, though the default behavior is non-clickable. To activate the clickable feature, click on the `󰍽` (mouse) icon on the far-right side.

Here are the components (some are hidden by default):

```text
┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ModeGitBranchGitDiffDiagnostics   FileName   SpacingEncodingFileFormatFiletypeLSPStatusSearchCountProgressPythonEnvClick│
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

| Icon | Name        | Description                                                    | On-click                                    |
| ---- | ----------- | -------------------------------------------------------------- | ------------------------------------------- |
|     | Mode        | Vim mode status                                                |                                             |
| 󰘬    | GitBranch   | (Optional) Current git branch                                  | Switch to another branch                    |
|      | GitDiff     | (Optional) Git diff status (: added, : modified, : removed) | Toggle diff-view                            |
|      | Diagnostics | (Optional) Diagnostics count from your preferred source        | Show diagnostics of current buffer          |
|      | FileName    | Path to the current file (from cwd)                            | Show file selection (`Oil.nvim`)            |
| 󱁐    | Spacing     | Number of spaces per tab (tabstop, softtabstop, shiftwidth)    | Switch to other spacing (2, 4, or 8)        |
|      | Encoding    | File encoding                                                  |                                             |
|      | FileFormat  | File format (unix, mac, dos)                                   | Switch to other file format                 |
|      | FileType    | File type of the current buffer                                | Switch to other file type (and restart LSP) |
|      | LSPStatus   | (Optional) Active LSP servers                                  | Show details of LSP config status           |
| 󰍉    | SearchCount | (Optional) Number of search matches when hlsearch is active    | Clear search highlighting                   |
|      | Progress    | Progress in file as row, col, and percentage                   |                                             |
| 󰌠    | PythonEnv   | Current Python environment                                     | Switch to other Python envs                 |
| 󰍽    | Click       | Currently clickable (󰍽) or non-clickable (󰍾)                   | Switch clickable status                     |

## 3. Useful default vim key-bindings

### 3.1. Standard navigation

| Group             | Functionality                                    | Key-binding               | Command   |
| ----------------- | ------------------------------------------------ | ------------------------- | --------- |
| Line navigation   | Go left/down/up/right                            | `h`/`j`/`k`/`l`           | -         |
|                   | Go next/previous (useful for menu items)         | `Ctrl+n`/`Ctrl+p`         | -         |
|                   | Go to start/end of current line                  | `0`/`$`                   | -         |
|                   | Go to non-blank start/end of current line        | `^`/`g_`                  | -         |
| Word navigation   | Go to next/previous beginning of a word          | `w`/`b`                   | -         |
|                   | Go to next/previous beginning of a WORD          | `W`/`B`                   | -         |
|                   | Go to end of a word                              | `e`                       | -         |
|                   | Go to end of a WORD                              | `E`                       | -         |
| Screen navigation | Go to first/last line                            | `gg`/`G`                  | -         |
|                   | Go to `i`-th line                                | `<i>gg` or `<i>G`         | `:<i>`    |
|                   | Move screen upward/downward (w.o. moving cursor) | `Ctrl+e`/`Ctrl+y`         | -         |
|                   | Go half-page up/down                             | `Ctrl+u`/`Ctrl+d`         | -         |
|                   | Go full-page backward/forward                    | `Ctrl+b`/`Ctrl+f`         | -         |
|                   | Go to top of the screen (high)                   | `H`                       | -         |
|                   | Go to middle of the screen (middle)              | `M`                       | -         |
|                   | Go to bottom of the screen (low)                 | `L`                       | -         |
|                   | Move current line to top of the screen           | `zt`                      | -         |
|                   | Move current line to middle of the screen        | `zz`                      | -         |
|                   | Move current line to bottom of the screen        | `zb`                      | -         |
| Search navigation | Search (forward) for pattern                     | `/<pattern>`              | -         |
|                   | Search (backward) for pattern                    | `?<pattern>`              | -         |
|                   | Go to next/previous matching pattern             | `n`/`N`                   | -         |
|                   | Clear search                                     | `Ctrl+l` (Neovim only)    | `:nohl`   |
| Split navigation  | Create a horizontal split                        | `Ctrl+w` `s`              | `:split`  |
|                   | Create a vertical split                          | `Ctrl+w` `v`              | `:vsplit` |
|                   | Go to left/down/up/right split                   | `Ctrl+w` `h`/`j`/`k`/`l`  | -         |
|                   | Move current split to the far left/down/up/right | `Ctrl+w` `H`/`J`/`K`/`L`  | -         |
|                   | Switch to the top-left split                     | `Ctrl+w` `t`              | -         |
|                   | Switch from (two) vertical to horizontal splits  | `Ctrl+w` `t` `Ctrl+w` `K` | -         |
|                   | Switch from (two) horizontal to vertical splits  | `Ctrl+w` `t` `Ctrl+w` `H` | -         |
|                   | Swap current split with the next                 | `Ctrl+w` `x`              | -         |
|                   | Increase/decrease height                         | `Ctrl+w` `+`/`-`          | -         |
|                   | Increase/decrease width                          | `Ctrl+w` `>`/`<`          | -         |
|                   | Max out height                                   | `Ctrl+w` `_`              | -         |
|                   | Max out width                                    | `Ctrl+w` `\|`             | -         |
|                   | Equal height/width for all splits                | `Ctrl+w` `=`              | -         |
| Other navigation  | Go to next/previous item in jumplist             | `Ctrl+i`/`Ctrl+o`         | -         |
|                   | Go to next/previous item in tab (tab != buffer)  | `gt`/`gT`                 | -         |

### 3.2. Buffers manipulation

| Functionality           | Command                               |
| ----------------------- | ------------------------------------- |
| Open file in new buffer | `:badd <filename>`                    |
| Go to next buffer       | `:bn`                                 |
| Go to previous buffer   | `:bp`                                 |
| Delete buffer           | `:bd`                                 |
| List all buffers        | `:ls`                                 |
| Go to a buffer          | `:b` `<buffer_index>`/`<buffer_name>` |

### 3.3. Substitution

General command (regex):

`<substitution_options>/<old_string>/<new_string>/<execution_options>`

Substitution options:

| Functionality                              | Key-binding |
| ------------------------------------------ | ----------- |
| Replace all                                | `%s`        |
| Replace the current line                   | `s`         |
| Replace from line 5 to line 12             | `5,12s`     |
| Replace from current line to the last line | `,$s`       |
| Replace within the selection (visual mode) | `'<,'>s`    |

Execution options:

| Functionality                | Key-binding |
| ---------------------------- | ----------- |
| Execute without confirmation | `g`         |
| Execute with confirmation    | `gc`        |

Examples:

- `:%s/foo/bar/g`: replace all `foo` by `bar`
- `:s/foo/bar/g`: replace `foo` by `bar` on the current line
- `:'<,'>s/foo/bar/g`: replace all `foo` by `bar` on the selection (visual mode)

### 3.4. Vim's default auto-completion (insert mode)

| Functionality                      | Key-binding     |
| ---------------------------------- | --------------- |
| Word/pattern completion - forward  | `Ctrl+x Ctrl+n` |
| Word/pattern completion - backward | `Ctrl+x Ctrl+p` |
| Line completion                    | `Ctrl+x Ctrl+l` |
| Filename completion                | `Ctrl+x Ctrl+f` |
| Omni completion **(my favorite)**  | `Ctrl+x Ctrl+o` |

More information: [link](https://www.thegeekstuff.com/2009/01/vi-and-vim-editor-5-awesome-examples-for-automatic-word-completion-using-ctrl-x-magic/)

### 3.5. Code folding

| Functionality    | Key-binding |
| ---------------- | ----------- |
| Toggle a fold    | `za`        |
| Close all folds  | `zM`        |
| Reopen all folds | `zR`        |

### 3.6. Spelling

Need to set up `spellfile` first (knvim already set it as `vim.fn.stdpath("data") .. "/spelling/en.utf-8.add"`). To turn spellchecking on, use the command: `:set spell` (turning off with `:set nospell`). You can specify which language as (e.g., en_us, en_gb, ...) `:set spell spelllang=en_us`. For more information, see `:h spell`.

| Functionality             | Key-binding |
| ------------------------- | ----------- |
| Spelling suggestions      | `z=`        |
| Add word to spell list    | `zg`        |
| Mark word as bad spelling | `zm`        |
| Previous misspelled word  | `[s`        |
| Next misspelled word      | `]s`        |

### 3.7. CTags key-bindings (requires CTags)

| Functionality        | Key-binding |
| -------------------- | ----------- |
| Go to definition     | `Ctrl+]`    |
| Preview definition   | `Ctrl+w }`  |
| Close preview window | `Ctrl+w z`  |

### 3.8. Commenting (new in Neovim 0.10)

| Functionality                                      | Key-binding  |
| -------------------------------------------------- | ------------ |
| Toggle comments for lines covered by motion        | `gc{motion}` |
| Toggle comments \[count\] lines starting at cursor | `gcc`        |
| Toggle comments on selected lines                  | `{Visual}gc` |

Enjoy!
