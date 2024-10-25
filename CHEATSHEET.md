JST's Neovim Configuration Cheatsheet

# Keymaps

## Legend

| Key Notation       | Meaning                                                                            |
| ------------------ | ---------------------------------------------------------------------------------- |
| `<S-…>`            | shift-key comined with next key                                                    |
| `<C-…>`            | control-key comined with next key                                                  |
| `<A-…>` or `<M-…>` | alt-key or meta-key comined with next key                                          |
| `<D-…>`            | command-key (MacOS) or "super" key (e.g., the "Windows" key) comined with next key |
| `<Leader>`         | A configurable key. **Space** (` `) is used in this config repository!             |
| `<CR>`             | Carriage return (Enter key)                                                        |

See `:help key-notation` for a complete list.

| Mode               | Meaning                                                                               |
| ------------------ | ------------------------------------------------------------------------------------- |
| n                  | Normal mode: When typing commands                                                     |
| i                  | Insert mode.  These are also used in Replace mode                                     |
| v                  | Visual mode or select mode: When typing commands while the Visual area is highlighted |
| x                  | Visual mode only                                                                      |
| o                  | Operator-pending mode: When an operator is pending (after "d", "y", "c", etc.)        |
| t                  | Terminal mode: When typing in a `:terminal` buffer                                    |

See `:help map-modes` for a complete list.

Note that Vim's and Neovim's default `<Leader>` is the backslash (`\`) key. You can change this to your liking, of course, just look for "mapleader" at the top of the `init.lua` file. More and more people change their default and the kickstart.nvim project uses  space by default and I left it as-is. See `:help mapleader` for details.

## Standard keymaps

| Mode | Mapping             | Description                                                 |
| ---- | ------------------- | ----------------------------------------------------------- |
| n    | `:q<cr>`            | \[Q]uit/close current buffer                                |
| n    | `:qa<cr>`           | \[Q]uit/close all buffers                                   |
| n    | `:qa!<cr>`          | \[Q]uit/close all buffers without saving                    |
| n    | `ZZ`                | Update (save if needed) and close window (`:update` + `:q`) |
| n    | `h`, `j`, `k`, `l`  | Move left(`h`), down(`j`), up(`k`), right(`l`)              |
| n    | `<C-w>s`            | \[W]indow \[S]plit horizontally                             |
| n    | `<C-w>v`            | \[W]indow split \[V]ertically                               |
| n    | `<C-w>h` or `<C-h>` | Navigate \[W]indow left(h)                                  |
| n    | `<C-w>j` or `<C-j>` | Navigate \[W]indow up(j)                                    |
| n    | `<C-w>k` or `<C-k>` | Navigate \[W]indow down(k)                                  |
| n    | `<C-w>l` or `<C-l>` | Navigate \[W]indow right(l)                                 |

## Miscellaneous

| Mode | Mapping      | Description                                         |
| ---- | ------------ | --------------------------------------------------- |
| n    | `<Esc>`      | Clear `hlsearch` on pressing `<Esc>` in normal mode |
| t    | `<C-\><C-n>` | Exit terminal mode (default)                        |
| t    | `<Esc><Esc>` | Exit terminal mode (alternate)                      |
| n    | `<Leader>?`  | Show buffer local keymaps (which-key)               |

## Searching (telescope)

| Mode      | Mapping                 | Description                                  |
| --------- | ----------------------- | -------------------------------------------- |
| n         | `<Leader>sh`            | \[S]earch \[H]elp                            |
| n         | `<Leader>sk`            | \[S]earch \[K]eymaps                         |
| n         | `<Leader>sf`            | \[S]earch \[F]iles (scoped)                  |
| n         | `<Leader>st`            | \[S]earch select \[T]elescope                |
| n         | `<Leader>sw`            | \[S]earch current \[W]ord                    |
| n         | `<Leader>sg`            | \[S]earch by live \[G]rep (scoped)           |
| n         | `<Leader>/`             | \[/] Fuzzily search in current buffer        |
| n         | `<Leader>s/`            | \[S]earch by live grep in open files         |
| n         | `<Leader>s.`            | \[S]earch recent files ("." for repeat)      |
| n         | `<Leader><Leader>`      | \[ ] Find existing buffers                   |
| n         | `<Leader>sd`            | \[S]earch \[D]iagnostics                     |
| n         | `<Leader>st`            | \[S]earch \[T]odo comments                   |
| n         | `<Leader>sn`            | \[S]earch \[N]eovim files                    |
| n         | `<Leader>se`            | \[S]earch symbols/\[E]mojis                  |
| n         | `<Leader>ss`            | \[S]earch select \[S]cope                    |
| n         | `<Leader>sr`            | \[S]earch \[R]esume                          |
| Telescope | `<Leader>/`             | Telescope help (`/` is `?` without shift)    |
| Telescope | `<C-c>` or `<Esc><Esc>` | Close telescope                              |
| Telescope | `<CR>`                  | Open selected entry in current window        |
| Telescope | `<C-v>`                 | Open selected entry in new vertial split     |
| Telescope | `<C-x>`                 | Open selected entry in new horizontal split  |

## More Nativation

| Mode | Mapping     | Description                                       |
| ---- |------------ |-------------------------------------------------- |
| n    | `]d`        | Goto next \[D]iagnostic                           |
| n    | `[d`        | Goto previous \[D]iagnostic                       |
| n    | `]q`        | Display the next \[Q]uickfix position (`:cn`)     |
| n    | `[q`        | Display the previous \[Q]uickfix position (`:cp`) |
| n    | `]c`        | Goto next \[C]hanged hunk                         |
| n    | `[c`        | Goto previous \[C]hanged hunk                     |
| n    | `]t`        | Goto next \[T]odo comment                         |
| n    | `[t`        | Goto previous \[T]odo comment                     |
| n    | `]s`        | Goto next mis\[S]pelled word                      |
| n    | `[s`        | Goto previous mis\[S]pelled word                  |
| n    | `'"`        | Goto last exited position in current buffer       |
| n    | `'.`        | Goto last modified position in current buffer     |
| n    | `<C-o>`     | Goto previous position in jump list               |
| n    | `<C-t>`     | Goto previous position in tag stack               |

## Completion (nvim-cmp, luasnip, ...)

| Mode | Mapping             | Description                                    |
| ---- | ------------------- | ---------------------------------------------- |
| i    | `<C-n>` or `<Down>` | Select \[N]ext item                            |
| i    | `<C-p>` or `<Up>`   | Select \[P]revious item                        |
| i    | `<C-b>`             | Scroll \[B]ack in documentation window         |
| i    | `<C-f>`             | Scroll \[F]orward in documentation window      |
| i    | `<C-y>`             | Accept (\[Y]es) completion                     |
| i, s | `<C-l>`             | Expand or jump to next snippet insert location |
| i, s | `<C-h>`             | Jump to previous snippet insert location       |

## Completion (GitHub Copilot)

| Mode | Mapping       | Description                                       |
| ---- | ------------- | ------------------------------------------------- |
| i    | `<Tab>`       | Accept completion                                 |
| i    | `<C-]>`       | Dismiss the current suggestion                    |
| i    | `<M-]>`       | Cycle to the next suggestion, if one is available |
| i    | `<M-\>`       | Explicitly request a suggestion                   |
| i    | `<M-Right>`   | Accept the next word of the current suggestion    |
| i    | `<M-C-Right>` | Accept the next line of the current suggestion    |

## AI (GitHub Copilot)

| Mode | Mapping       | Description                                       |
| ---- | ------------- | ------------------------------------------------- |
| n, v | `<Leader>cc`  | Run \[C]opilot \[C]hat                            |
| n, v | `<Leader>ccf` | Run \[C]opilot \[C]hat \[F]ix                     |

## Language Server Protocol (LSP)

| Mode | Mapping      | Description                         | Notes                                                                                                     |
| ---- | ------------ | ----------------------------------- | --------------------------------------------------------------------------------------------------------- |
| n    | `]d`         | Goto next \[D]iagnostic             |                                                                                                           |
| n    | `[d`         | Goto previous \[D]iagnostic         |                                                                                                           |
| n    | `gd`         | \[G]oto \[D]efinition               | Jump to the definition of the word under your cursor.                                                     |
| n    | `gD`         | \[G]oto \[D]eclaration              | Jump to the declaration of the word under your cursor.                                                    |
| n    | `gr`         | \[G]oto \[R]eferences               | Find references for the word under your cursor.                                                           |
| n    | `gI`         | \[G]oto \[I]mplementation           | Jump to the implementation of the word under your cursor.                                                 |
| n    | `<Leader>D`  | Type \[D]efinition                  | Jump to the type of the word under your cursor, the definition of its *type*, not where it was *defined*. |
| n    | `<Leader>ds` | \[D]ocument \[S]ymbols              | Fuzzy find all the symbols in your current document.                                                      |
| n    | `<Leader>ws` | \[W]orkspace \[S]ymbols             | Fuzzy find all the symbols in your current workspace.                                                     |
| n    | `<Leader>rn` | \[R]e\[N]ame                        | Rename the variable under your cursor.                                                                    |
| n    | `<Leader>ca` | \[C]ode \[A]ction                   | Execute a code action, usually your cursor needs to be on top of an error or a suggestion.                |
| n    | `K`          | Hover documentation (see `:help K`) | Opens a popup that displays documentation about the word under your cursor.                               |
| n    | `<Leader>e`  | Show diagnostic \[E]rror messages   |                                                                                                           |
| n    | `<Leader>q`  | Open diagnostic \[Q]uickfix list    |                                                                                                           |

## Quickfix

| Mode | Mapping     | Description                                       |
| ---- | ----------- | ------------------------------------------------- |
| n    | `<F4>`      | Display the next \[Q]uickfix position (`:cn`)     |
| n    | `]q`        | Display the next \[Q]uickfix position (`:cn`)     |
| n    | `[q`        | Display the previous \[Q]uickfix position (`:cp`) |
| n    | `<Leader>q` | Open diagnostic \[Q]uickfix list                  |

## Various toggles (toggle-lsp-diagnostics, nvim-lspconfig, etc)

| Mode | Mapping        | Description                                                                            |                                                                                |
| ---- | -------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| n    | `<Leader>tlu`  | \[T]oggle \[L]sp diagnostics \[U]nderline                                              |                                                                                |
| n    | `<Leader>tls`  | \[T]oggle \[L]sp diagnostics \[S]igns                                                  |                                                                                |
| n    | `<Leader>tlv`  | \[T]oggle \[L]sp diagnostics \[V]irtual text                                           |                                                                                |
| n    | `<Leader>tlp`  | \[T]oggle \[L]sp diagnostics information u\[P]date while in insert mode                |                                                                                |
| n    | `<Leader>tld`  | \[T]oggle \[L]sp diagnostics                                                           |                                                                                |
| n    | `<Leader>tldd` | \[T]oggle \[L]sp diagnostics back to \[D]efaults (on, except overrides passed on init) |                                                                                |
| n    | `<Leader>tldo` | \[T]oggle \[L]sp diagnostics \[O]n                                                     |                                                                                |
| n    | `<Leader>tldf` | \[T]oggle \[L]sp diagnostics o\[F]f                                                    |                                                                                |
| n    | `<Leader>tlh`  | \[T]oggle \[L]sp inlay \[H]ints                                                        | Few LSPs support inlay hints: `lua_ls`, `pylyzer`, `slangd`, `clangd` (>=15.0) |
| n    | `<Leader>tb`   | \[T]oggle current line \[B]lame                                                        |                                                                                |
| n    | `<Leader>td`   | \[T]oggle \[D]eleted hunks                                                             |                                                                                |
| n    | `<Leader>tp`   | \[T]oggle \[P]aste mode                                                                |                                                                                |
| n    | `<Leader>ts`   | \[T]oggle \[S]ign column                                                               |                                                                                |
| n    | `<Leader>tv`   | \[T]oggle \[V]irtual edit                                                              |                                                                                |
| n    | `<Leader>to`   | \[T]oggle \[O]utline                                                                   |                                                                                |
| n    | `<Leader>tm`   | \[T]oggle \[M]arkview (markdown files)                                                 |                                                                                |

## Cscope (cscope_maps)

Cscope is deprecated and disabled by default (see lua/plugins/cscope_maps.lua). LSPs (e.g., clangd) are preferred.

| Mode | Mapping      | Description                                             |
| ---- | ------------ | ------------------------------------------------------- |
| n    | `<Leader>cs` | Find all references to the token/\[S]ymbol under cursor |
| n    | `<Leader>cg` | Find \[G]lobal definition(s) of the token under cursor  |
| n    | `<Leader>cc` | Find all \[C]alls to the function name under cursor     |
| n    | `<Leader>ct` | Find all instances of the \[T]ext under cursor          |
| n    | `<Leader>ce` | \[E]grep search for the word under cursor               |
| n    | `<Leader>cf` | Open the \[F]ilename under cursor                       |
| n    | `<Leader>ci` | Find files that \[I]nclude the filename under cursor    |
| n    | `<Leader>cd` | Find functions that function under cursor calls         |
| n    | `<Leader>ca` | Find places where this symbol is \[A]ssigned a value    |
| n    | `<Leader>cb` | \[B]uild cscope database                                |
| n    | `<C-]>`      | Do `:Cstag <cword>`                                     |

## Git (fugitive, gitsigns)

| Mode | Mapping      | Description                                    |
| ---- | ------------ | ---------------------------------------------- |
| n    | `]c`         | Goto next \[C]hanged hunk                      |
| n    | `[c`         | Goto previous \[C]hanged hunk                  |
| n, v | `<Leader>hs` | \[H]unk \[S]tage                               |
| n, v | `<Leader>hr` | \[H]unk \[R]eset                               |
| n    | `<Leader>hu` | \[H]unk stage \[U]ndo                          |
| n    | `<Leader>hS` | \[S]tage buffer                                |
| n    | `<Leader>hR` | \[R]eset buffer                                |
| n    | `<Leader>hp` | \[H]unk \[P]review                             |
| n    | `<Leader>hb` | \[H]unk \[B]lame                               |
| n    | `<Leader>hd` | Perform vim\[D]iff                             |
| n    | `<Leader>hD` | Perform vim\[D]iff last commit                 |
| o, x | `ih`         | Select hunk (after movement or in visual mode) |
| n    | `<Leader>tb` | \[T]oggle current line \[B]lame                |
| n    | `<Leader>td` | \[T]oggle \[D]eleted hunks                     |

## Comments (numToStr/Comment)

| Mode | Mapping             | Description                                                        |
| ---- | ------------------- | ------------------------------------------------------------------ |
| n    | `gcc`               | Toggles the current line using linewise comment                    |
| n    | `gbc`               | Toggles the current line using blockwise comment                   |
| n    | `[count]gcc`        | Toggles the number of line given as a prefix-count using linewise  |
| n    | `[count]gbc`        | Toggles the number of line given as a prefix-count using blockwise |
| n    | `gc[count]{motion}` | (Op-pending) Toggles the region using linewise comment             |
| n    | `gb[count]{motion}` | (Op-pending) Toggles the region using blockwise comment            |
| v    | `gc`<br>            | Toggles the region using linewise comment                          |
| v    | `gb`                | Toggles the region using blockwise comment                         |

## Folding (builtin)

These are default keymaps but folding is provided by Treesitter so is much more accurate than Vim's old regex-based folding.

| Mode | Mapping  | Description                                                        |
| ---- | -------- | ------------------------------------------------------------------ |
| n    | `zR`     | Open all folds (updates `foldlevel=max`)                           |
| n    | `zM`     | \[C]lose all folds (updates `foldlevel=0`)                         |
| n    | `zo`     | \[O]pen one fold under the cursor                                  |
| n    | `zc`     | \[C]pen one fold under the cursor                                  |
| n    | `za`     | Toggle the fold under the cursor                                   |
| n    | `zO`     | \[O]pen all folds under the cursor, recursively                    |
| n    | `zC`     | \[C]lose all folds under the cursor, recursively                   |
| n    | `zA`     | Toggle all folds under the cursor, resursively                     |
| n    | `zv`     | Open enough folds to \[V]iew the cursor line                       |
| n    | `zr`     | \[R]educe folding (updates `foldlevel++`)                          |
| n    | `zm`     | Fold \[M]ore (updates `foldlevel--`)                               |
| n    | `zx`     | Updates all folds (re-apply `foldlevel`) and view the cursor line  |
| n    | `zX`     | Updates all folds (re-apply `foldlevel`)                           |

## Window & tmux pane navigation (vim-tmux-navigator)

If you use tmux, you should setup the [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm) and install the [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator/?tab=readme-ov-file#tpm) plugin in tmux. This will let you navigate seamlessly between Neovim windows and tmux panes.

| Mode | Mapping     | Description                                         |
| ---- | ----------- | --------------------------------------------------- |
| n    | `<C-h>`     | Navigate split left (Tmux aware)                    |
| n    | `<C-j>`     | Navigate split down (Tmux aware)                    |
| n    | `<C-k>`     | Navigate split up (Tmux aware)                      |
| n    | `<C-l>`     | Navigate split right (Tmux aware) and clear+redraw  |
| n    | `<C-\>`     | Navigate to previous split (Tmux aware)             |
| n    | `<C-Space>` | Navigate to next split, by pane number (Tmux aware) |

P.S.: If you love the combination of Neovim and tmux and you have a QMK/VIA programmable keyboard like me, try configuring your Fn+arrow keys to `C-h/j/k/l`!

## GUI

When running a graphical version of Neovim, like [Neovim-QT](https://github.com/equalsraf/neovim-qt), these mappings are available.

| Mode    | Mapping      | Description                                                        |
| ------- | ------------ | ------------------------------------------------------------------ |
| v       | `<C-+>`      | Copy: Copy the selection to the clipboard\[+]                      |
| i, c, n | `<S-insert>` | Paste: Insert the content of the clipboard(+)                      |
| i, c, n | `<S-C-v>`    | Paste: Insert the content of the clipboard(+)                      |
