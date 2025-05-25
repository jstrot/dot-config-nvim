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

## Searching (telescope, snacks.picker)

| Mode      | Mapping                 | Description                                  |
| --------- | ----------------------- | -------------------------------------------- |
| n         | `<Leader>sh`            | \[S]earch \[H]elp                            |
| n         | `<Leader>sk`            | \[S]earch \[K]eymaps                         |
| n         | `<Leader>sf`            | \[S]earch \[F]iles (scoped)                  |
| n         | `<Leader>sp`            | \[S]earch \[P]ickers                         |
| n         | `<Leader>sw`            | \[S]earch current \[W]ord                    |
| n         | `<Leader>sg`            | \[S]earch by live \[G]rep (scoped)           |
| n         | `<Leader>/`             | \[/] Fuzzily search in current buffer        |
| n         | `<Leader>s/`            | \[S]earch by live grep in open buffers       |
| n         | `<Leader>sr`            | \[S]earch \[R]ecent files                    |
| n         | `<Leader>sj`            | \[S]earch \[J]ump list                       |
| n         | `<Leader><Leader>`      | \[ ] Find existing buffers                   |
| n         | `<Leader>sd`            | \[S]earch workspace \[D]iagnostics           |
| n         | `<Leader>sD`            | \[S]earch buffer \[D]iagnostics              |
| n         | `<leader>slr`           | \[S]earch \[L]SP \[R]eferences               |
| n         | `<leader>sli`           | \[S]earch \[L]SP \[I]mplementations          |
| n         | `<Leader>st`            | \[S]earch \[T]odo comments                   |
| n         | `<Leader>sn`            | \[S]earch \[N]eovim files                    |
| n         | `<Leader>se`            | \[S]earch symbols/\[E]mojis                  |
| n         | `<Leader>sb`            | \[S]earch \[B]ibtex references               |
| n         | `<Leader>ss`            | \[S]earch select \[S]cope                    |
| n         | `<Leader>s!`            | \[S]earch notifications\[!]                  |
| n         | `<Leader>s.`            | \[S]earch resume/repeat (`.` = repeat)       |
| Telescope | `<Leader>/`             | Telescope help (`/` is `?` without shift)    |
| Telescope | `<C-c>` or `<Esc><Esc>` | Close telescope                              |
| Telescope | `<CR>`                  | Open selected entry in current window        |
| Telescope | `<C-v>`                 | Open selected entry in new vertial split     |
| Telescope | `<C-x>`                 | Open selected entry in new horizontal split  |

## More Nativation

| Mode | Mapping     | Description                                       |
| ---- | ----------- |-------------------------------------------------- |
| n    | `]d` / `[d` | Goto next/previous \[D]iagnostic                  |
| n    | `]e` / `[e` | Goto next/previous diagnostic \[E]rror            |
| n    | `]q` / `[q` | Goto next/previous \[Q]uickfix position (`:cn`)   |
| n    | `]c` / `[c` | Goto next/previous \[C]hanged hunk                |
| n    | `]t` / `[t` | Goto next/previous \[T]odo comment                |
| n    | `]s` / `[s` | Goto next/previous mis\[S]pelled word             |
| n    | `'"`        | Goto last exited position in current buffer       |
| n    | `'.`        | Goto last modified position in current buffer     |
| n    | `<C-o>`     | Goto previous position in jump list               |
| n    | `<C-i>`     | Goto next position in jump list                   |
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

## AI

| Mode | Mapping          | Description                                       |
| ---- | ---------------- | ------------------------------------------------- |
| n, v | `<Leader>cc<cr>` | Run \[C]opilot \[C]hat                            |
| n    | `<Leader>cc<cr>` | Run OGPT \[C]hat                                  |
| n, v | `<Leader>ccf`    | Run \[C]opilot \[C]hat \[F]ix                     |

## Language Server Protocol (LSP)

| Mode | Mapping          | Description                         | Notes                                                                                                     |
| ---- | ---------------- | ----------------------------------- | --------------------------------------------------------------------------------------------------------- |
| n    | `]d`             | Goto next \[D]iagnostic             |                                                                                                           |
| n    | `[d`             | Goto previous \[D]iagnostic         |                                                                                                           |
| n    | `gd`             | \[G]oto \[D]efinition               | Jump to the definition of the word under your cursor.                                                     |
| n    | `gD`             | \[G]oto \[D]eclaration              | Jump to the declaration of the word under your cursor.                                                    |
| n    | `<leader>slr`    | \[S]earch \[L]SP \[R]eferences      | Find references for the word under your cursor.                                                           |
| n    | `<leader>sli`    | \[S]earch \[L]SP \[I]mplementations | Jump to the implementation of the word under your cursor.                                                 |
| n    | `<Leader>D`      | Type \[D]efinition                  | Jump to the type of the word under your cursor, the definition of its *type*, not where it was *defined*. |
| n    | `<Leader>ds`     | \[D]ocument \[S]ymbols              | Fuzzy find all the symbols in your current document.                                                      |
| n    | `<Leader>ws`     | \[W]orkspace \[S]ymbols             | Fuzzy find all the symbols in your current workspace.                                                     |
| n    | `<Leader>rn`     | \[R]e\[N]ame                        | Rename the variable under your cursor.                                                                    |
| n    | `<Leader>ca`     | \[C]ode \[A]ction                   | Execute a code action, usually your cursor needs to be on top of an error or a suggestion.                |
| n    | `K`              | Hover documentation (see `:help K`) | Opens a popup that displays documentation about the word under your cursor.                               |
| n    | `<Leader>e`      | Show diagnostic \[E]rror messages   |                                                                                                           |
| n    | `<Leader>q`      | Open diagnostic \[Q]uickfix list    |                                                                                                           |
| n, v | `<Leader>f<cr>`  | \[F]ormat using "conform"           |                                                                                                           |
| n, v | `<Leader>fl`     | \[F]ormat using \[L]SP              |                                                                                                           |

## Inspection (Introspection and Information)

| Mode | Mapping          | Description                                       | Notes         |
| ---- | ---------------- | ------------------------------------------------- | ------------- |
| n    | `<Leader>id`     | \[I]nspect word in \[D]ictionary                  | opt-in        |

## Quickfix

| Mode | Mapping     | Description                                       |
| ---- | ----------- | ------------------------------------------------- |
| n    | `<F4>`      | Display the next \[Q]uickfix position (`:cn`)     |
| n    | `]q`        | Display the next \[Q]uickfix position (`:cn`)     |
| n    | `[q`        | Display the previous \[Q]uickfix position (`:cp`) |
| n    | `<Leader>q` | Open diagnostic \[Q]uickfix list                  |

## Various toggles (toggle-lsp-diagnostics, nvim-lspconfig, etc)

| Mode | Mapping           | Description                                                                               | Notes                                                                          |
| ---- | ----------------- | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| n    | `<Leader>ta`      | \[T]oggle \[A]NSI escape codes                                                            |                                                                                |
| n    | `<Leader>td<cr>`  | \[T]oggle \[D]iff mode                                                                    |                                                                                |
| n    | `<Leader>tdb`     | \[T]oggle \[D]iff ignore \[B]lank lines                                                   |                                                                                |
| n    | `<Leader>tdc`     | \[T]oggle \[D]iff ignore \[C]ase of text                                                  |                                                                                |
| n    | `<Leader>tdw`     | \[T]oggle \[D]iff ignore \[W]hite spaces                                                  |                                                                                |
| n    | `<Leader>tf`      | \[T]oggle auto\[F]ormat on save using "conform"                                           |                                                                                |
| n    | `<Leader>tgb`     | \[T]oggle \[G]it current line \[B]lame                                                    |                                                                                |
| n    | `<Leader>tgd`     | \[T]oggle \[G]it \[D]eleted hunks                                                         |                                                                                |
| n    | `<Leader>ti`      | \[T]oggle \[I]ndent highlighting                                                          |                                                                                |
| n    | `<Leader>tld<cr>` | \[T]oggle \[L]SP \[D]iagnostics                                                           |                                                                                |
| n    | `<Leader>tldd`    | \[T]oggle \[L]SP \[D]iagnostics back to \[D]efaults (on, except overrides passed on init) |                                                                                |
| n    | `<Leader>tldf`    | \[T]oggle \[L]SP \[D]iagnostics o\[F]f                                                    |                                                                                |
| n    | `<Leader>tldo`    | \[T]oggle \[L]SP \[D]iagnostics \[O]n                                                     |                                                                                |
| n    | `<Leader>tlh`     | \[T]oggle \[L]SP inlay \[H]ints                                                           | Few LSPs support inlay hints: `lua_ls`, `pylyzer`, `slangd`, `clangd` (>=15.0) |
| n    | `<Leader>tlp`     | \[T]oggle \[L]SP diagnostics information u\[P]date while in insert mode                   |                                                                                |
| n    | `<Leader>tls`     | \[T]oggle \[L]SP diagnostics \[S]igns                                                     |                                                                                |
| n    | `<Leader>tlu`     | \[T]oggle \[L]SP diagnostics \[U]nderline                                                 |                                                                                |
| n    | `<Leader>tlv`     | \[T]oggle \[L]SP diagnostics \[V]irtual text                                              |                                                                                |
| n    | `<Leader>tL`      | \[T]oggle \[L]arge file handling                                                          |                                                                                |
| n    | `<Leader>tm`      | \[T]oggle \[M]arkview (markdown files)                                                    |                                                                                |
| n    | `<Leader>to`      | \[T]oggle \[O]utline                                                                      |                                                                                |
| n    | `<Leader>tp`      | \[T]oggle \[P]aste mode                                                                   |                                                                                |
| n    | `<Leader>ts<cr>`  | \[T]oggle \[S]ign column                                                                  |                                                                                |
| n    | `<Leader>ts0`     | \[T]oggle \[S]ign column: 0 wide (no/off)                                                 |                                                                                |
| n    | `<Leader>ts1`     | \[T]oggle \[S]ign column: 1 wide                                                          |                                                                                |
| n    | `<Leader>ts2`     | \[T]oggle \[S]ign column: 2 wide                                                          |                                                                                |
| n    | `<Leader>ts3`     | \[T]oggle \[S]ign column: 3 wide                                                          |                                                                                |
| n    | `<Leader>tsc`     | \[T]oggle \[S]ign column \[C]overage info                                                 |                                                                                |
| n    | `<Leader>tsg`     | \[T]oggle \[S]ign column \[G]it info                                                      |                                                                                |
| n    | `<Leader>tsl`     | \[T]oggle \[S]ign column \[L]SP diagnostics                                               |                                                                                |
| n    | `<Leader>tt<cr>`  | \[T]oggle \[T]reesitter highlight                                                         |                                                                                |
| n    | `<Leader>ttb`     | \[T]oggle \[T]reesitter highlight in \[B]uffer                                            |                                                                                |
| n    | `<Leader>tti`     | \[T]oggle \[T]reesitter \[I]ndent                                                         |                                                                                |
| n    | `<Leader>ttc`     | \[T]oggle \[T]reesitter \[C]ontext                                                        |                                                                                |
| n    | `<Leader>tsn`     | \[T]oggle \[S]ign column line \[N]umber                                                   |                                                                                |
| n    | `<Leader>tv`      | \[T]oggle \[V]irtual edit                                                                 |                                                                                |
| n    | `<Leader>tw`      | \[T]oggle \[W]rap mode                                                                    |                                                                                |
| n    | `<Leader>tz`      | \[T]oggle \[Z]en mode                                                                     |                                                                                |
| n    | `<Leader>t=`      | \[T]oggle \[S]pell mode                                                                   | `g=` for spelling suggestions                                                  |

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

## Git (fugitive, gitsigns, snacks.gitbrowse)

| Mode | Mapping       | Description                                                 |
| ---- | ------------- | ----------------------------------------------------------- |
| n    | `]c`          | Goto next \[C]hanged hunk                                   |
| n    | `[c`          | Goto previous \[C]hanged hunk                               |
| n, v | `<Leader>gs`  | \[G]it \[S]tage hunk                                        |
| n, v | `<Leader>gr`  | \[G]it \[R]eset hunk                                        |
| n    | `<Leader>gu`  | \[G]it \[U]ndo stage hunk                                   |
| n    | `<Leader>gS`  | \[G]it \[S]tage buffer                                      |
| n    | `<Leader>gR`  | \[G]it \[R]eset buffer                                      |
| n    | `<Leader>gp`  | \[G]it \[P]review hunk                                      |
| n    | `<Leader>gc`  | \[G]it \[C]ommit                                            |
| n    | `<Leader>gb`  | \[G]it \[B]lame line                                        |
| n    | `<Leader>gB`  | \[G]it \[B]rowse repo online                                |
| n    | `<Leader>gd`  | \[G]it vim\[D]iff file against the index                    |
| n    | `<Leader>gD`  | \[G]it vim\[D]iff file against the last commit              |
| o, x | `ih`          | Select \[I]nside \[H]unk (after movement or in visual mode) |
| n    | `<Leader>tgb` | \[T]oggle \[G]it current line \[B]lame                      |
| n    | `<Leader>tgd` | \[T]oggle \[G]it \[D]eleted hunks                           |
| n    | `<Leader>tsg` | \[T]oggle \[S]ign column \[G]it info                        |

## Comments (numToStr/Comment)

| Mode | Mapping             | Description                                                        |
| ---- | ------------------- | ------------------------------------------------------------------ |
| n    | `gcc`               | Toggles the current line using linewise comment                    |
| n    | `gbc`               | Toggles the current line using blockwise comment                   |
| n    | `[count]gcc`        | Toggles the number of line given as a prefix-count using linewise  |
| n    | `[count]gbc`        | Toggles the number of line given as a prefix-count using blockwise |
| n    | `gc[count]{motion}` | (Op-pending) Toggles the region using linewise comment             |
| n    | `gb[count]{motion}` | (Op-pending) Toggles the region using blockwise comment            |
| v    | `gc`                | Toggles the region using linewise comment                          |
| v    | `gb`                | Toggles the region using blockwise comment                         |

## Markdown

| Mode | Mapping             | Description                                                        |
| ---- | ------------------- | ------------------------------------------------------------------ |
| i    | `<cr>` or `<C-cr>`  | On bullet line, inserts a new bullet list item based on the current line bullet format |
| n    | `o`                 | On bullet line, inserts a new bullet list item and starts insert mode                  |
| n, v | `gN`                | On bullet line, renumbers entire list containing the current cursor position           |
| n    | `<leader>x`         | On bullet line, toggles the checkbox (if any)                                          |
| i    | `<C-Right>`         | On bullet line, demotes the current bullet item by indenting the line.                 |
| n    | `>>`                | On bullet line, demotes the current bullet item by indenting the line.                 |
| v    | `>`                 | On bullet line, demotes the selected bullet items by indenting the lines.              |
| i    | `<C-Left>`          | On bullet line, promotes the current bullet item by unindenting the line.              |
| n    | `<<`                | On bullet line, promotes the current bullet item by unindenting the line.              |
| v    | `<`                 | On bullet line, promotes the selected bullet items by unindenting the lines.           |
| n    | `<Leader>tm`        | \[T]oggle \[M]arkview                                                                  |

- bullet keymaps apply to Markdown files and others like "text", "gitcommit", and "scratch".

## Text operations (mini.operators)

See `:help mini.operators` for more details.

For each operator the following mappings are created:

- In Normal mode to operate on textobject. Uses `prefix` directly.
- In Normal mode to operate on line. Appends to `prefix` the last character.
  This aligns with |operator-doubled| and established patterns for operators
  with more than two characters, like |guu|, |gUU|, etc.
- In Visual mode to operate on visual selection. Uses `prefix` directly.

| Mapping prefix  | Description                                                        |
| --------------- | ------------------------------------------------------------------ |
| `g=`            | Evaluate text and replace with output                              |
| `gx`            | Exchange text regions                                              |
| `gm`            | Multiply (duplicate) text                                          |
| `gr`            | Replace text with register                                         |
| `gs`            | Sort text                                                          |

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


# Fuzzy Search Syntax

See [fzf's Search syntax](https://github.com/junegunn/fzf#search-syntax) for more details.

Unless otherwise specified, fzf starts in "extended-search mode" where you can
type in multiple search terms delimited by spaces. e.g. `^music .mp3$ sbtrkt
!fire`

| Token     | Match type                              | Description                                  |
| --------- | --------------------------------------  | ------------------------------------------   |
| `sbtrkt`  | fuzzy-match                             | Items that match `sbtrkt`                    |
| `'wild`   | exact-match (quoted)                    | Items that include `wild`                    |
| `'wild'`  | exact-boundary-match (quoted both ends) | Items that include `wild` at word boundaries |
| `^music`  | prefix-exact-match                      | Items that start with `music`                |
| `.mp3$`   | suffix-exact-match                      | Items that end with `.mp3`                   |
| `!fire`   | inverse-exact-match                     | Items that do not include `fire`             |
| `!^music` | inverse-prefix-exact-match              | Items that do not start with `music`         |
| `!.mp3$`  | inverse-suffix-exact-match              | Items that do not end with `.mp3`            |

A single bar character term acts as an OR operator. For example, the following
query matches entries that start with `core` and end with either `go`, `rb`,
or `py`.

```
^core go$ | rb$ | py$
```
