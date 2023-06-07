# My NeoVim cheatsheet

(The default `<leader>` is `\`)

## 1. Custom Vim key-bindings

### 1.1. Fn key-bindings

Overall logic:
- `F1-4`: toggle things
- `F5-6`: buffers/tabs
- `F10-12`: random frequently used things

| Functionality                            | Key-binding                  |
| ---------------------------------------- | ---------------------------- |
| Search for help                          | `F1`                         |
| Rename variables                         | `F2`                         |
| Toggle file explorer                     | `F3` (or `<leader> t`)       |
| Toggle symbol view                       | `F4` (or `<leader> o`)       |
|                                          |                              |
| Show key-bindings                        | `Shift+F1`                   |
| Open to-do list (project-wise)           | `Shift+F2`                   |
| Toggle file explorer at the current file | `Shift+F3` (or `<leader> T`) |
| Open diagnostic list (project-wise)      | `Shift+F4` (or `<leader> E`) |
|                                          |                              |
| Show buffer list                         | `F5`                         |
| Previous buffer                          | `F6` (or `Ctrl+Alt+h`)       |
| Next buffer                              | `F7` (or `Ctrl+Alt+l`)       |
| Close the current buffer                 | `F8` (or `Ctrl+Alt+Shift+k`) |
|                                          |                              |
| Show tab list                            | `Shift+F5`                   |
| Previous tab                             | `Shift+F6`                   |
| Next tab                                 | `Shift+F7`                   |
| Close the current tab                    | `Shift+F8`                   |
|                                          |                              |
| Remove trailing spaces                   | `F9`                         |
| Run the `make` command                   | `F10`                        |
| Toggle zoom the current window (splits)  | `F11`                        |
| Toggle relative number                   | `F12`                        |
|                                          |                              |
| Clear registers                          | `Shift+F9`                   |
| Run the `make clean` command             | `Shift+F10`                  |
| Toggle color code colorizing (e.g., CSS) | `Shift+F11`                  |
| Toggle welcome screen                    | `Shift+F12`                  |


### 1.2. Telescope key-bindings

| Functionality                       | Key-binding       |
| ----------------------------------- | ----------------- |
| Open Telescope                      | `<space> <space>` |
| Fuzzy search for *f*ilename         | `<space> f`       |
| Fuzzy search for *t*ext             | `<space> t`       |
| Fuzzy search for *b*uffer           | `<space> b`       |
| Fuzzy search for *s*ession          | `<space> s`       |
| Fuzzy search for bibtex *c*itations | `<space> c`       |
| Fuzzy search for *v*im options      | `<space> v`       |
| File bro*w*ser using Telescope      | `<space> w`       |
| Show *n*otification history         | `<space> n`       |
| Fuzzy search in the current buffer  | `<space> /`       |


### 1.3. LSP-related key-bindings

| Functionality                                         | Key-binding   |
| ----------------------------------------------------- | ------------- |
| Go to *d*efinitions                                   | `gd`          |
| Go to *i*mplementation                                | `gi`          |
| Go to *r*eference                                     | `gr`          |
| Go to *t*ype definition                               | `gt`          |
| Show function documentation (on hover)                | `K`           |
| Show signature help (while typing function arguments) | `Ctrl+k`      |
|                                                       |               |
| Rename variables                                      | `<leader> rn` |
| Code action (if supported by the language server)     | `<leader> ca` |
| Code formatting (if supported by the language server) | `<leader> f`  |
|                                                       |               |
| Open *e*rror (diagnostic) list (project-wise)         | `<leader> E`  |
| Show current line's error                             | `<leader> e`  |
| Go to previous error                                  | `[e`          |
| Go to next error                                      | `]e`          |
|                                                       |               |
| *A*dd *w*orkspace folder                              | `<leader> wa` |
| *R*emove *w*orkspace folder                           | `<leader> wr` |
| *L*ist *w*orkspace folder                             | `<leader> wl` |


### 1.4. Window and buffer navigation

Overall logic:
- `Alt`: for split manipulation (with `Shift` to swap)
- `Ctrl+Alt`: for buffer manipulation (with `Shift` for extra functionalities)

| Functionality                 | Key-binding          |
| ----------------------------- | -------------------- |
| Switch to the left window     | `Alt+h`              |
| Switch to the lower window    | `Alt+j`              |
| Switch to the upper window    | `Alt+k`              |
| Switch to the right window    | `Alt+l`              |
| Swap with the left window     | `Alt+Shift+h`        |
| Swap with the lower window    | `Alt+Shift+j`        |
| Swap with the upper window    | `Alt+Shift+k`        |
| Swap with the right window    | `Alt+Shift+l`        |
|                               |                      |
| Switch to the previous buffer | `Ctrl+Alt+h`         |
| Switch to the next buffer     | `Ctrl+Alt+l`         |
| *J*ump to a buffer            | `Ctrl+Alt+j`         |
| *K*ill a buffer               | `Ctrl+Alt+k`         |
| Swap with the previous buffer | `Ctrl+Alt+Shift+h`   |
| Swap with the next buffer     | `Ctrl+Alt+Shift+l`   |
| Restore a closed buffer       | `Ctrl+Alt+Shift+j`   |
| Kill the current buffer       | `Ctrl+Alt+Shift+k`   |
| Pin/unpin the current buffer  | `Ctrl+Alt+p`         |


### 1.5. DAP key-bindings

| Functionality                                   | Key-binding          |
| ----------------------------------------------- | -------------------- |
| Toggle DAP UI                                   | `,d`                 |
| Toggle DAP defautl REPL                         | `,D`                 |
| Toggle DAP breakpoint                           | `,b`                 |
| Toggle DAP breakpoint with condition            | `,B`                 |
| Continue DAP debugging                          | `,c`                 |
| Run last DAP launcher (if there are many)       | `,l`                 |
| Step over                                       | `,n`                 |
| Step into                                       | `,i`                 |
| Step out                                        | `,o`                 |
| Terminate debugging                             | `,t`                 |
| Hover variable while debugging                  | `,h`                 |


### 1.6. Other custom key-bindings

| Functionality                                   | Key-binding          |
| ----------------------------------------------- | -------------------- |
| Insert python breakpoint (on the next line)     | `<leader> b`         |
| Insert python breakpoint (on the previous line) | `<leader> B`         |
| Insert '-' characters                           | `<leader> -`         |
| Insert '=' characters                           | `<leader> =`         |
| Generate doc string for function                | `<leader> d`         |
| Toggle file explorer                            | `<leader> t`         |
| Toggle symbol view                              | `<leader> o`         |
| Dismiss current notification message            | `<leader> n`         |
|                                                 |                      |
| Toggle terminal                                 | `<Ctrl+\>`           |
|                                                 |                      |
| Fuzzy motion mode                               | `s`                  |
|                                                 |                      |
| Go to previous hunk of Git *c*hange             | `[c`                 |
| Go to next hunk of Git *c*hange                 | `]c`                 |
|                                                 |                      |
| Toggle line-wise comment (normal mode)          | `gcc` or `Ctrl+/`    |
| Toggle line-wise comment (visual mode)          | `gc`                 |
| Toggle block-wise comment (normal mode)         | `gbc`                |
| Toggle block-wise comment (visual mode)         | `gb`                 |
|                                                 |                      |
| Start easy align (in visual mode)               | `<leader>a`          |
| - Easy align by `|`                             | `<leader>a*|`        |
| - Easy align by ` `                             | `<leader>a* `        |


## 2. Default useful vim key-bindings

### 2.1. Standard navigation

| Group             | Functionality                             | Key-binding                 | Command   |
| ----------------- | ----------------------------------------- | --------------------------- | --------- |
| Line navigation   | Go left/down/up/right                     | `h`/`j`/`k`/`l`             |           |
|                   | Go next/previous (useful for menu items)  | `Ctrl+n`/`Ctrl+p`           |           |
|                   | Go to start/end of current line           | `0`/`$`                     |           |
|                   | Go to non-blank start/end of current line | `^`/`g_`                    |           |
| Word navigation   | Go to next/previous beginning of a word   | `w`/`b`                     |           |
|                   | Go to end of a word                       | `e`                         |           |
| Screen navigation | Go to first/last line                     | `gg`/`G`                    |           |
|                   | Go to `n`-th line                         | `<n>gg` or `<n>G`           | `:n`      |
|                   | Go half-page up/down                      | `Ctrl+u`/`Ctrl+d`           |           |
|                   | Go full-page backward/forward             | `Ctrl+b`/`Ctrl+f`           |           |
| Search navigation | Search (forward) for pattern              | `/<pattern>`                |           |
|                   | Search (backward) for pattern             | `?<pattern>`                |           |
|                   | Go to next/previous matching pattern      | `n`/`N`                     |           |
| Window navigation | Create a horizontal split                 | `<Ctrl+w> s`                | `:split`  |
|                   | Create a vertical split                   | `<Ctrl+w> v`                | `:vsplit` |
|                   | Go to left/down/up/right split            | `Ctrl+w` `h`/`j`/`k`/`l`    |           |


### 2.2. Substitution

General command:

`<substitution_options>/<old_string>/<new_string>/<execution_options>`

Substitution options:

| Functionality                              | Key-binding |
| ------------------------------------------ | ----------- |
| Replace all                                | `%s`        |
| Replace the current line                   | `s`         |
| Replace from line 5 to line 12             | `5,12s`     |
| Replace from current line to the last line | `,$s`       |

Execution options:

| Functionality                | Key-binding |
| ---------------------------- | ----------- |
| Execute without confirmation | `g`         |
| Execute with confirmation    | `gc`        |

Examples:

- `:%s/foo/bar/g`: replace all `foo` by `bar`
- `:s/foo/bar/g`: replace `foo` by `bar` on the current line


### 2.3. Vim's default auto-completion (insert mode)

| Functionality                      | Key-binding     |
| ---------------------------------- | --------------- |
| Word/pattern completion - forward  | `Ctrl+x Ctrl+n` |
| Word/pattern completion - backward | `Ctrl+x Ctrl+p` |
| Line completion                    | `Ctrl+x Ctrl+l` |
| Filename completion                | `Ctrl+x Ctrl+f` |
| Omni completion **(my favorite)**  | `Ctrl+x Ctrl+o` |

More information: [link](https://www.thegeekstuff.com/2009/01/vi-and-vim-editor-5-awesome-examples-for-automatic-word-completion-using-ctrl-x-magic/)


### 2.4. Ctags key-bindings (requires Ctags)

| Functionality        | Key-binding |
| -------------------- | ----------- |
| Go to definition     | `Ctrl+]`    |
| Preview definition   | `Ctrl+w }`  |
| Close preview window | `Ctrl+w z`  |


### 2.5. Code folding

| Functionality    | Key-binding |
| ---------------- | ----------- |
| Toggle a fold    | `za`        |
| Close all folds  | `zM`        |
| Reopen all folds | `zR`        |


### 2.6. Spellings

| Functionality            | Key-binding   |
| ------------------------ | ------------- |
| Spelling suggestions     | `z=`          |
| Add word to spell list   | `zg`          |
| Previous misspelled word | `[s`          |
| Next misspelled word     | `]s`          |


### 2.7. Buffers manipulation

| Functionality           | Command                               |
| ----------------------- | ------------------------------------- |
| Open file in new buffer | `:badd <filename>`                    |
| Go to next buffer       | `:bn`                                 |
| Go to previous buffer   | `:bp`                                 |
| Delete buffer           | `:bd`                                 |
| List all buffers        | `:ls`                                 |
| Go to a buffer          | `:b` `<buffer_index>`/`<buffer_name>` |
