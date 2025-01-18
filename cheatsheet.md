# Knvim cheatsheet

(The default `<leader>` is `\`)

## 1. Custom key-bindings

### 1.1. Fn key-bindings

Overall logic:

- `F1-4`: toggle things
- `F5-6`: buffers/tabs
- `F9-12`: random frequently used things

| Group                 | Functionality                             | Key-binding                  |
| --------------------- | ----------------------------------------- | ---------------------------- |
| `F1-4`: toggle things | Search for help                           | `F1` (or `<space> h`)        |
|                       | Rename variables                          | `F2` (or `<leader> rn`)      |
|                       | Toggle file explorer                      | `F3` (or `<leader> t`)       |
|                       | Toggle symbol view                        | `F4` (or `<leader> o`)       |
|                       | Show key-bindings                         | `Shift+F1` (or `<space> k`)  |
|                       | Open to-do list (project-wise)            | `Shift+F2`                   |
|                       | Toggle file explorer at the current file  | `Shift+F3` (or `<leader> T`) |
|                       | Open diagnostic list (project-wise)       | `Shift+F4` (or `<space> d`)  |
| `F5-8`: buffers/tabs  | Show buffer list                          | `F5` (or `<space> b`)        |
|                       | Previous buffer                           | `F6` (or `Ctrl+Alt+h`)       |
|                       | Next buffer                               | `F7` (or `Ctrl+Alt+l`)       |
|                       | Close the current buffer                  | `F8` (or `Ctrl+Alt+Shift+k`) |
|                       | Show tab list                             | `Shift+F5`                   |
|                       | Previous tab                              | `Shift+F6`                   |
|                       | Next tab                                  | `Shift+F7`                   |
|                       | Close the current tab                     | `Shift+F8`                   |
| `F9-12`: others       | Remove trailing spaces                    | `F9`                         |
|                       | Run the `make` command                    | `F10`                        |
|                       | Toggle zoom the current window (splits)   | `F11` (or `<leader> z`)      |
|                       | Toggle relative number                    | `F12`                        |
|                       | Replace curly quotes with straight quotes | `Shift+F9`                   |
|                       | Run the `make clean` command              | `Shift+F10`                  |
|                       | Toggle color code colorizing (e.g., CSS)  | `Shift+F11`                  |
|                       | Toggle welcome screen                     | `Shift+F12`                  |

### 1.2. Snacks key-bindings

#### 1.2.1 Snacks.picker (fuzzy finder) key-bindings

All picker key-bindings start with `<space>`.

| Functionality             | Key-binding       |
| ------------------------- | ----------------- |
| Open Snacks picker        | `<space> <space>` |
| Find *f*iles              | `<space> f`       |
| Find *t*ext (grep)        | `<space> t`       |
| Find *b*uffer             | `<space> b`       |
| Find *h*elp               | `<space> h`       |
| Find *k*eymap             | `<space> k`       |
| Find *c*ommands           | `<space> c`       |
| Find *m*arks              | `<space> m`       |
| Find *r*egisters          | `<space> r`       |
| Find *d*iagnostics        | `<space> d`       |
| Find Python *e*nvironment | `<space> e`       |
| Find hovered word         | `<space> *`       |
| Find in open buffers      | `<space> /`       |

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

#### 1.2.2. Other Snacks key-bindings

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

### 1.3. LSP key-bindings

| Group       | Functionality                                         | Key-binding                   |
| ----------- | ----------------------------------------------------- | ----------------------------- |
| Navigation  | Go to *d*efinitions                                   | `gd`                          |
|             | Go to *i*mplementation                                | `gi`                          |
|             | Go to *r*eference                                     | `gr`                          |
|             | Go to t*y*pe definition                               | `gy`                          |
|             | Go to *f*ile path (not LSP, vim default)              | `gf`                          |
| Misc        | Show function documentation (on hover)                | `K`                           |
|             | Show signature help (while typing function arguments) | `Ctrl+k`                      |
|             | Rename variables                                      | `<leader> rn`                 |
|             | Code action (if supported)                            | `<leader> ca`                 |
|             | Code formatting (if supported)                        | `<leader> f`                  |
|             | Toggle inlay-hint (if supported)                      | `<leader> i`                  |
| Diagnostics | Open *d*iagnostic list (project-wise)                 | `<space> d`                   |
|             | Show current line's diagnostics                       | `Ctrl+w d` or `Ctrl+w Ctrl+d` |
|             | Go to previous diagnostic                             | `[d`                          |
|             | Go to next diagnostic                                 | `]d`                          |
| Workspace   | *A*dd *w*orkspace folder                              | `<leader> wa`                 |
|             | *R*emove *w*orkspace folder                           | `<leader> wr`                 |
|             | *L*ist *w*orkspace folder                             | `<leader> wl`                 |

### 1.4. Window and buffer navigation

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

### 1.5. DAP key-bindings

All DAP key-bindings start with `,`.

| Functionality                             | Key-binding |
| ----------------------------------------- | ----------- |
| Toggle DAP UI                             | `,d`        |
| Toggle DAP defautl REPL                   | `,D`        |
| Toggle DAP breakpoint                     | `,b`        |
| Toggle DAP breakpoint with condition      | `,B`        |
| Continue DAP debugging                    | `,c`        |
| Run last DAP launcher (if there are many) | `,l`        |
| Step over                                 | `,n`        |
| Step into                                 | `,s`        |
| Step out                                  | `,u`        |
| Terminate debugging                       | `,t`        |
| Hover variable while debugging            | `,k`        |
| Generate launcher for python              | `,g`        |

### 1.6. Vim matchup

Navigate to beginning/end of a function. Convenient for long functions. This is the default key-bindings from the plugins, but I'm too lazy to make a different section :P

| Functionality                             | Key-binding |
| ----------------------------------------- | ----------- |
| Cycle to next matching word               | `%`         |
| Go to {count}-th previous outer open word | `[%`        |
| Go to {count}-th next outer open word     | `]%`        |
| Go to inside {count}-th nearest block     | `z%`        |

### 1.7. Other custom key-bindings

| Group      | Functionality                                   | Key-binding          |
| ---------- | ----------------------------------------------- | -------------------- |
| Misc       | **Show local key-maps in the buffer**           | `<leader> ?`         |
|            | Insert python breakpoint (on the next line)     | `<leader> b`         |
|            | Insert python breakpoint (on the previous line) | `<leader> B`         |
|            | Fill line with `─` characters                   | `<leader> -`         |
|            | Fill line with `━` characters                   | `<leader> =`         |
|            | Generate doc string for function                | `<leader> d`         |
|            | Toggle file-tree                                | `<leader> t`         |
|            | Toggle file-tree and jump to current file       | `<leader> T`         |
|            | Toggle outline view (on the screen right side)  | `<leader> o`         |
|            | Toggle outline view (beside current buffer)     | `<leader> O`         |
|            | In insert mode, `Alt+h,j,k,l` becomes arrows    | `Alt+h,j,k,l`        |
| Oil        | Open oil in floating window                     | `-`                  |
|            | Open oil in the current buffer                  | `_`                  |
|            | Close oil and return to the previous buffer     | `Ctrl+c` or `q`      |
| Git hunk   | Go to previous hunk of Git change               | `[c`                 |
|            | Go to next hunk of Git change                   | `]c`                 |
| Easy-align | Start easy align (in visual mode)               | `<leader> a`         |
|            | - _Example:_ align by `\|`                      | `<leader> a*\|`      |
|            | - _Example:_ align by `<space>`                 | `<leader> a*<space>` |
| Neogen     | Generate docstring                              | `<leader> d`         |
| Markdown   | Toggle markdown render                          | `<leader> m`         |
|            | Cycle through checkbox marks                    | `Ctrl+<space>`       |

## 2. Useful default vim key-bindings

### 2.1. Standard navigation

| Group             | Functionality                                    | Key-binding              | Command   |
| ----------------- | ------------------------------------------------ | ------------------------ | --------- |
| Line navigation   | Go left/down/up/right                            | `h`/`j`/`k`/`l`          | -         |
|                   | Go next/previous (useful for menu items)         | `Ctrl+n`/`Ctrl+p`        | -         |
|                   | Go to start/end of current line                  | `0`/`$`                  | -         |
|                   | Go to non-blank start/end of current line        | `^`/`g_`                 | -         |
| Word navigation   | Go to next/previous beginning of a word          | `w`/`b`                  | -         |
|                   | Go to next/previous beginning of a WORD          | `W`/`B`                  | -         |
|                   | Go to end of a word                              | `e`                      | -         |
|                   | Go to end of a WORD                              | `E`                      | -         |
| Screen navigation | Go to first/last line                            | `gg`/`G`                 | -         |
|                   | Go to `i`-th line                                | `<i>gg` or `<i>G`        | `:<i>`    |
|                   | Move screen upward/downward (w.o. moving cursor) | `Ctrl+e`/`Ctrl+y`        | -         |
|                   | Go half-page up/down                             | `Ctrl+u`/`Ctrl+d`        | -         |
|                   | Go full-page backward/forward                    | `Ctrl+b`/`Ctrl+f`        | -         |
|                   | Go to top of the screen (high)                   | `H`                      | -         |
|                   | Go to middle of the screen (middle)              | `M`                      | -         |
|                   | Go to bottom of the screen (low)                 | `L`                      | -         |
|                   | Move current line to top of the screen           | `zt`                     | -         |
|                   | Move current line to middle of the screen        | `zz`                     | -         |
|                   | Move current line to bottom of the screen        | `zb`                     | -         |
| Search navigation | Search (forward) for pattern                     | `/<pattern>`             | -         |
|                   | Search (backward) for pattern                    | `?<pattern>`             | -         |
|                   | Go to next/previous matching pattern             | `n`/`N`                  | -         |
|                   | Clear search                                     | `Ctrl+l` (Neovim only)   | `:nohl`   |
| Split navigation  | Create a horizontal split                        | `Ctrl+w` `s`             | `:split`  |
|                   | Create a vertical split                          | `Ctrl+w` `v`             | `:vsplit` |
|                   | Go to left/down/up/right split                   | `Ctrl+w` `h`/`j`/`k`/`l` | -         |
|                   | Move current split to the far left/down/up/right | `Ctrl+w` `H`/`J`/`K`/`L` | -         |
|                   | Swap current split with the next                 | `Ctrl+w` `x`             | -         |
|                   | Increase/decrease height                         | `Ctrl+w` `+`/`-`         | -         |
|                   | Increase/decrease width                          | `Ctrl+w` `>`/`<`         | -         |
|                   | Max out height                                   | `Ctrl+w` `_`             | -         |
|                   | Max out width                                    | `Ctrl+w` `\|`            | -         |
|                   | Equal height/width for all splits                | `Ctrl+w` `=`             | -         |
| Other navigation  | Go to next/previous item in jumplist             | `Ctrl+i`/`Ctrl+o`        | -         |
|                   | Go to next/previous item in tab (tab != buffer)  | `gt`/`gT`                | -         |

### 2.2. Buffers manipulation

| Functionality           | Command                               |
| ----------------------- | ------------------------------------- |
| Open file in new buffer | `:badd <filename>`                    |
| Go to next buffer       | `:bn`                                 |
| Go to previous buffer   | `:bp`                                 |
| Delete buffer           | `:bd`                                 |
| List all buffers        | `:ls`                                 |
| Go to a buffer          | `:b` `<buffer_index>`/`<buffer_name>` |

### 2.3. Substitution

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

### 2.4. Vim's default auto-completion (insert mode)

| Functionality                      | Key-binding     |
| ---------------------------------- | --------------- |
| Word/pattern completion - forward  | `Ctrl+x Ctrl+n` |
| Word/pattern completion - backward | `Ctrl+x Ctrl+p` |
| Line completion                    | `Ctrl+x Ctrl+l` |
| Filename completion                | `Ctrl+x Ctrl+f` |
| Omni completion **(my favorite)**  | `Ctrl+x Ctrl+o` |

More information: [link](https://www.thegeekstuff.com/2009/01/vi-and-vim-editor-5-awesome-examples-for-automatic-word-completion-using-ctrl-x-magic/)

### 2.5. Code folding

| Functionality    | Key-binding |
| ---------------- | ----------- |
| Toggle a fold    | `za`        |
| Close all folds  | `zM`        |
| Reopen all folds | `zR`        |

### 2.6. Spelling

Need to set up `spellfile` first (knvim already set it as `vim.fn.stdpath("data") .. "/spelling/en.utf-8.add"`). To turn spellchecking on, use the command: `:set spell` (turning off with `:set nospell`). You can specify which language as (e.g., en_us, en_gb, ...) `:set spell spelllang=en_us`. For more information, see `:h spell`.

| Functionality             | Key-binding |
| ------------------------- | ----------- |
| Spelling suggestions      | `z=`        |
| Add word to spell list    | `zg`        |
| Mark word as bad spelling | `zm`        |
| Previous misspelled word  | `[s`        |
| Next misspelled word      | `]s`        |

### 2.7. Ctags key-bindings (requires Ctags)

| Functionality        | Key-binding |
| -------------------- | ----------- |
| Go to definition     | `Ctrl+]`    |
| Preview definition   | `Ctrl+w }`  |
| Close preview window | `Ctrl+w z`  |

### 2.8. Commenting (new in Neovim 0.10)

| Functionality                                      | Key-binding  |
| -------------------------------------------------- | ------------ |
| Toggle comments for lines covered by motion        | `gc{motion}` |
| Toggle comments \[count\] lines starting at cursor | `gcc`        |
| Toggle comments on selected lines                  | `{Visual}gc` |
