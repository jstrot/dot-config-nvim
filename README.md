JST's Neovim Configuration

Hi, I'm [Jean-Sébastien Trottier](jst@qualipsoft.com), owner of qualIP Software and Tech Lead at Cisco, working on the IOS-XR platform.
This is my Neovim configuration.


# Introduction

Let's get things straight:
Neovim is not an **IDE**, it's a **text editor**!
Neovim is a fork of Vim that focuses on extensibility and usability. 

But it's not like any other *configurable* text editor like Sublime Text, Atom, or VS Code.
Neovim is highly extensible using the Lua programming language. This means that you are not limited to the features provided by the core editor or a predetermines set of configurations in a JSON file.

In short, as [TJ DeVries](https://github.com/tjdevries) coins it, it is a **PDE**, a **Personalised Development Environment**: You write code to mould the editor to your taste, your habits, your workflow.
With the help of plugins, it can be made to *look* like an IDE but it will always be much more than just an IDE.


# Features

This configuration repository comes preinstalled with many plugins that offer a wide range of features. Here are some of the highlights:

- Language servers (LSPs) (clangd, ...)
- GitHub Copilot integration (completion & chat)
- Code completion
- Code formatting
- Diagnostic messages
- Snippets
- Code coverage integration
- Nerd fonts support
- Fuzzy finder (Telescope)
- Git integration (Fugitive, Gitsigns)
- Advanced syntax-based highlighting and indentation (Treesitter)
- Cosmetic candy (icons, colorschemes, statusline, ...)
- Tmux integration (vim-tmux-navigator)


# Let's go!

## Clone the repository to setup your initial Neovim config

Before starting, I'm assuming you have no prior Neovim configuration directory (`~/.config/nvim`)
```sh
git clone https://TODO/dot-config-nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

## Neovim executable location

First, make sure you have a recent version of Neovim installed by picking one at <https://github.com/neovim/neovim/releases>.

> [!TIP]
> On Linux, the AppImage is the simplest to get going.
> Download it to your `~/bin` and link it with `ln -s ~/bin/nvim.appimage ~/bin/nvim`.

The Neovim executable is the one called named `nvim`!

## Nerd/Patched fonts

Enable support for Nerd/patched fonts. 

It is highly recommended to install a patched font that contains extended characters for development (Icons for "bugs", "git", "github", file types, ...). Many plugins rely on the availability of patched fonts.

The easy way is to download a font from <https://www.nerdfonts.com/>, install it in your OS (if you're running remotely over ssh, for example, that's the host running your terminal emulator!) and then enable that font in your terminal's configuration. A good starting point is to try the one I use, "DroidSansM Nerd Font", a patched version of the "Droid Sans Mono" which has fairly square letters and scalable to small sizes without issues.

### MacOS

#### OS: MacOS

Run the "Font Book" application and use the "Install Font" button to add your Nerd font files (decompress the .zip!).

<!-- TODO: How to select the default monospace font? -->

#### Terminal: iTerm2

<!-- TODO: How to select the font or the default? -->

### Windows

#### OS: Windows

Copy the font files (decompress the .zip!) into the `C:/Windows/Fonts` directory.

<!-- TODO: How to select the default monospace font? -->

#### Windows Terminal

<!-- TODO: How to select the font or the default? -->

### Linux

In most modern distributions, you can copy the font's .otf files (decompress the .zip!) to your `~/.local/share/fonts/` and run `fc-cache -f -v` to update the font cache.

It can also be added for all users copying to `/usr/local/share/fonts` as root and running `sudo fc-cache -f -v`.

Now applications can select the font (some applications may need to be restarted to see new fonts).

#### Display Manager: Gnome

To make it the default monospace font, install and run the "Gnome Tweaks" application (`gnome-tweaks` package). Under the "Fonts" section, set "Monospace Text" to your Nerd font.

#### Display Manager: KDE

<!-- TODO: How to select the default monospace font? -->

#### Application: Gnome Terminal

Shift-Right-Click in Gnome Terminal, select the "Preferences" mena, then select a profile on the left (e.g., "Unnamed"). The font selection is under the "Text" tab.

If you made your Nerd font the default monotype font, just make sure the "Custom font" is unchecked.
Otherwise, or if you want to override the default size too, check the box and select your Nerd font.

#### Application: Terminator

This is my preference as Terminator is written in Python, has more options than Gnome Terminal, and is easily extandable with plugins.

Shift-Right-Click in Terminator, select the "Preferences" mena, then the "Profiles" tab, and select your profile (e.g., "default"). The font selection is under the "General" tab.

If you made your Nerd font the default monotype font, just make sure the "Use the system fixed width font" is checked.
Otherwise, or if you want to override the default size too, uncheck the box and select your Nerd font.

#### Example: xterm under VNC

<!-- TODO: What's needed here? Suggest a better setup too!! -->

### Not a Nerd?

If you can't or don't want to enable Nerd/patched fonts, make sure to set the `have_nerd_font` global variable to `false` by editing this line in your `init.lua`:

```lua
vim.g.have_nerd_font = false
```

## Getting started with Neovim

For newbies and seasoned veterans alike, these are great starting points to enhance your Neovim experience:

- kickstart.nvim's (TJ DeVries's) [The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)
- Run the tutorial within Neovim: `:Tutor`
- Read the configs and explanations in `~/.config/nvim/init.lua`

## Configuration language and init file

Vim's configuration language is "Vimscript".
Neovim's configuration language is "Lua".

Vimscript is still available but Lua is more powerful.

Neovim's main configuration file is:

    ~/.config/nvim/init.lua

Other Lua files are contained under this directory:

    ~/.config/nvim/lua/

## Basic configuration files structure

There are many ways to structure your configuration files. Some like a single "init.lua", others like to have plugins separated in a single "plugins.lua" (~/.config/nvim/lua/plugins.lua).

To better organize files and help with file sharing, I prefer to put plugins each in its own file under a "plugins/" directory and configurations by topic under a "config/" directory. Like this:

```
$ tree ~/.config/nvim
~/.config/nvim
├── init.lua
├── lua
│   ├── config
│   │   └── lazy.lua
│   └── plugins
│       ├── coc.lua
│       ├── CopilotChat.lua
│       ├── Copilot.lua
│       ├── fzf.lua
│       ├── LargeFile.lua
│       ├── lualine.lua
│       ├── lualine-so-fancy.lua
│       ├── LunarVim-Colorschemes.lua
│       ├── none-ls.lua
│       ├── nvim-coverage.lua
│       ├── nvim-lspconfig.lua
│       ├── nvim-treesitter-context.lua
│       ├── nvim-treesitter.lua
│       ├── nvim-web-devicons.lua
│       ├── telescope.lua
│       ├── toggle-lsp-diagnostics.lua
│       ├── vim-clang-format.lua
│       └── vim-fugitive.lua
│       └── ...
└── ...
```
## The main init.lua

The init.lua sets up your default variables, loads plugins and configs.

In this repository, the main init.lua file is based on the one from the [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) project as well as customizations from myself, [Jean-Sébastien Trottier (JST)](mailto:jst@qualipsoft.com). The kickstart plugins are moved to individual directories to ease maintenance and sharing and many more are added.

Feel free to modify all of this to your liking. Remember, it's your **PDE**!


# Cheatsheet

## Keymaps

### Standard keymaps

| Mode | Mapping             | Description                                                 |
| ---- | ------------------- | ----------------------------------------------------------- |
| n    | `<C-w>s`            | \[W]indow \[S]plit horizontally                             |
| n    | `<C-w>v`            | \[W]indow split \[V]ertically                               |
| n    | `<C-w>h` or `<C-h>` | Navigate \[W]indow left(h)                                  |
| n    | `<C-w>j` or `<C-j>` | Navigate \[W]indow up(j)                                    |
| n    | `<C-w>k` or `<C-k>` | Navigate \[W]indow down(k)                                  |
| n    | `<C-w>l` or `<C-l>` | Navigate \[W]indow right(l)                                 |
| n    | `ZZ`                | Update (save if needed) and close window (`:update` + `:q`) |

### Miscellaneous

| Mode | Mapping      | Description                                         |
| ---- | ------------ | --------------------------------------------------- |
| n    | `<Esc>`      | Clear `hlsearch` on pressing `<Esc>` in normal mode |
| t    | `<C-\><C-n>` | Exit terminal mode (default)                        |
| t    | `<Esc><Esc>` | Exit terminal mode (alternate)                      |

### Searching (telescope)

| Mode      | Mapping            | Description                               |
| --------- | ------------------ | ----------------------------------------- |
| n         | `<leader>sh`       | \[S]earch \[H]elp                         |
| n         | `<leader>sk`       | \[S]earch \[K]eymaps                      |
| n         | `<leader>sf`       | \[S]earch \[F]iles                        |
| n         | `<leader>ss`       | \[S]earch \[S]elect Telescope             |
| n         | `<leader>sw`       | \[S]earch current \[W]ord                 |
| n         | `<leader>sg`       | \[S]earch by live \[G]rep                 |
| n         | `<leader>/`        | \[/] Fuzzily search in current buffer     |
| n         | `<leader>s/`       | \[S]earch by live grep in open files      |
| n         | `<leader>s.`       | \[S]earch recent files ("." for repeat)   |
| n         | `<leader><leader>` | \[ ] Find existing buffers                |
| n         | `<leader>sd`       | \[S]earch \[D]iagnostics                  |
| n         | `<leader>sn`       | \[S]earch \[N]eovim files                 |
| n         | `<leader>sr`       | \[S]earch \[R]esume                       |
| Telescope | `<leader>/`        | Telescope help (`/` is `?` without shift) |

### Completion (nvim-cmp, luasnip, ...)

| Mode | Mapping             | Description                                    |
| ---- | ------------------- | ---------------------------------------------- |
| i    | `<C-n>` or `<Down>` | Select \[N]ext item                            |
| i    | `<C-p>` or `<Up>`   | Select \[P]revious item                        |
| i    | `<C-b>`             | Scroll \[B]ack in documentation window         |
| i    | `<C-f>`             | Scroll \[F]orward in documentation window      |
| i    | `<C-y>`             | Accept (\[Y]es) completion                     |
| i, s | `<C-l>`             | Expand or jump to next snippet insert location |
| i, s | `<C-h>`             | Jump to previous snippet insert location       |


### Completion (GitHub Copilot)

| Mode | Mapping       | Description                                       |
| ---- | ------------- | ------------------------------------------------- |
| i    | `<Tab>`       | Accept completion                                 |
| i    | `<C-]>`       | Dismiss the current suggestion                    |
| i    | `<M-]>`       | Cycle to the next suggestion, if one is available |
| i    | `<M-\>`       | Explicitly request a suggestion                   |
| i    | `<M-Right>`   | Accept the next word of the current suggestion    |
| i    | `<M-C-Right>` | Accept the next line of the current suggestion    |


### Language Server Protocol (LSP)

| Mode | Mapping      | Description                         | Notes                                                                                                     |
| ---- | ------------ | ----------------------------------- | --------------------------------------------------------------------------------------------------------- |
| n    | `]d`         | Goto next \[D]iagnostic             |                                                                                                           |
| n    | `[d`         | Goto previous \[D]iagnostic         |                                                                                                           |
| n    | `gd`         | \[G]oto \[D]efinition               | Jump to the definition of the word under your cursor.                                                     |
| n    | `gD`         | \[G]oto \[D]eclaration              | Jump to the declaration of the word under your cursor.                                                    |
| n    | `gr`         | \[G]oto \[R]eferences               | Find references for the word under your cursor.                                                           |
| n    | `gI`         | \[G]oto \[I]mplementation           | Jump to the implementation of the word under your cursor.                                                 |
| n    | `<leader>D`  | Type \[D]efinition                  | Jump to the type of the word under your cursor, the definition of its *type*, not where it was *defined*. |
| n    | `<leader>ds` | \[D]ocument \[S]ymbols              | Fuzzy find all the symbols in your current document.                                                      |
| n    | `<leader>ws` | \[W]orkspace \[S]ymbols             | Fuzzy find all the symbols in your current workspace.                                                     |
| n    | `<leader>rn` | \[R]e\[N]ame                        | Rename the variable under your cursor.                                                                    |
| n    | `<leader>ca` | \[C]ode \[A]ction                   | Execute a code action, usually your cursor needs to be on top of an error or a suggestion.                |
| n    | `K`          | Hover documentation (see `:help K`) | Opens a popup that displays documentation about the word under your cursor.                               |
| n    | `<leader>e`  | Show diagnostic \[E]rror messages   |                                                                                                           |
| n    | `<leader>q`  | Open diagnostic \[Q]uickfix list    |                                                                                                           |

### Quickfix

| Mode | Mapping     | Description                                             |
| ---- | ----------- | ------------------------------------------------------- |
| n    | `<F4>`      | Display the next error in the quickfix list (`:cn`)     |
| n    | `]q`        | Display the next error in the quickfix list (`:cn`)     |
| n    | `[q`        | Display the previous error in the quickfix list (`:cp`) |
| n    | `<leader>q` | Open diagnostic \[Q]uickfix list                        |

### Various toggles (toggle-lsp-diagnostics, nvim-lspconfig, etc)

| Mode | Mapping        | Description                                                                            |                                                                                |
| ---- | -------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| n    | `<leader>tlu`  | \[T]oggle \[L]sp diagnostics \[U]nderline                                              |                                                                                |
| n    | `<leader>tls`  | \[T]oggle \[L]sp diagnostics \[S]igns                                                  |                                                                                |
| n    | `<leader>tlv`  | \[T]oggle \[L]sp diagnostics \[V]irtual text                                           |                                                                                |
| n    | `<leader>tlp`  | \[T]oggle \[L]sp diagnostics information u\[P]date while in insert mode                |                                                                                |
| n    | `<leader>tld`  | \[T]oggle \[L]sp diagnostics                                                           |                                                                                |
| n    | `<leader>tldd` | \[T]oggle \[L]sp diagnostics back to \[D]efaults (on, except overrides passed on init) |                                                                                |
| n    | `<leader>tldo` | \[T]oggle \[L]sp diagnostics \[O]n                                                     |                                                                                |
| n    | `<leader>tldf` | \[T]oggle \[L]sp diagnostics o\[F]f                                                    |                                                                                |
| n    | `<leader>tlh`  | \[T]oggle \[L]sp inlay \[H]ints                                                        | Few LSPs support inlay hints: `lua_ls`, `pylyzer`, `slangd`, `clangd` (>=15.0) |
| n    | `<leader>tb`   | \[T]oggle current line \[B]lame                                                        |                                                                                |
| n    | `<leader>td`   | \[T]oggle \[D]eleted hunks                                                             |                                                                                |
| n    | `<leader>tp`   | \[T]oggle \[P]aste mode                                                                |                                                                                |
| n    | `<leader>ts`   | \[T]oggle \[S]ign column                                                               |                                                                                |

### Cscope (cscope_maps)

Cscope is deprecated and disabled by default (see lua/plugins/cscope_maps.lua). LSPs (e.g., clangd) are preferred.

| Mode | Mapping      | Description                                             |
| ---- | ------------ | ------------------------------------------------------- |
| n    | `<leader>cs` | Find all references to the token/\[S]ymbol under cursor |
| n    | `<leader>cg` | Find \[G]lobal definition(s) of the token under cursor  |
| n    | `<leader>cc` | Find all \[C]alls to the function name under cursor     |
| n    | `<leader>ct` | Find all instances of the \[T]ext under cursor          |
| n    | `<leader>ce` | \[E]grep search for the word under cursor               |
| n    | `<leader>cf` | Open the \[F]ilename under cursor                       |
| n    | `<leader>ci` | Find files that \[I]nclude the filename under cursor    |
| n    | `<leader>cd` | Find functions that function under cursor calls         |
| n    | `<leader>ca` | Find places where this symbol is \[A]ssigned a value    |
| n    | `<leader>cb` | \[B]uild cscope database                                |
| n    | `<C-]>`      | Do `:Cstag <cword>`                                     |

### Git (fugitive, gitsigns)

| Mode | Mapping      | Description                                    |
| ---- | ------------ | ---------------------------------------------- |
| n    | `]c`         | Goto next \[C]hanged hunk                      |
| n    | `[c`         | Goto previous \[C]hanged hunk                  |
| n, v | `<leader>hs` | \[H]unk \[S]tage                               |
| n, v | `<leader>hr` | \[H]unk \[R]eset                               |
| n    | `<leader>hu` | \[H]unk stage \[U]ndo                          |
| n    | `<leader>hS` | \[S]tage buffer                                |
| n    | `<leader>hR` | \[R]eset buffer                                |
| n    | `<leader>hp` | \[H]unk \[P]review                             |
| n    | `<leader>hb` | \[H]unk \[B]lame                               |
| n    | `<leader>hd` | Perform vim\[D]iff                             |
| n    | `<leader>hD` | Perform vim\[D]iff last commit                 |
| o, x | `ih`         | Select hunk (after movement or in visual mode) |
| n    | `<leader>tb` | \[T]oggle current line \[B]lame                |
| n    | `<leader>td` | \[T]oggle \[D]eleted hunks                     |

### Comments (numToStr/Comment)

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

# Window & tmux pane navigation (vim-tmux-navigator)

If you use tmux, you should setup the [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm) and install the [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator/?tab=readme-ov-file#tpm) plugin in tmux. This will let you navigate seamlessly between Neovim windows and tmux panes.

| Mode | Mapping     | Description                                         |
| ---- | ----------- | --------------------------------------------------- |
| n    | `<C-h>`     | Navigate split left (Tmux aware)                    |
| n    | `<C-j>`     | Navigate split down (Tmux aware)                    |
| n    | `<C-k>`     | Navigate split up (Tmux aware)                      |
| n    | `<C-l>`     | Navigate split right (Tmux aware)                   |
| n    | `<C-\>`     | Navigate to previous split (Tmux aware)             |
| n    | `<C-Space>` | Navigate to next split, by pane number (Tmux aware) |

P.S.: If you love the combination of Neovim and tmux and you have a QMK/VIA programmable keyboard like me, try configuring your Fn+arrow keys to Ctrl-h/j/k/l!


# Advanced Configuration

## Python venv for Neovim

Setting up a Python virtual environment for Neovim to use is a good idea to keep your Neovim Python dependencies separate from your system Python dependencies.

### Install pyenv (if you don't have it yet)

I strongly suggest you install `pyenv` to manage your Python versions and `pyenv-virtualenv` to manage your Python virtual environments. Both get installed automatically by this script (see <https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer> for details):

```sh
curl https://pyenv.run | bash
```

Add this to your rc files, preferably to your main profile rc file (`~/.profile`) which gets sources by Display Managers.

```sh
# https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer
if [ -d "${PYENV_ROOT:-$HOME/.pyenv}" ] ; then
    export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
    [ -d $PYENV_ROOT/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
```

Make sure your shell's own profile rc (`~/.bashrc`, `~/.zprofile`, ...) sources `~/.profile` so it gets loaded in remote login sessions too.

Close the shell and start new login session or run the above code inline to activate the changes.

Next, install a recent Python 3 version (According to <https://www.python.org/downloads/>, 3.12.4 is the latest bugfix release as of this writing):

```sh
pyenv install 3.12.4
```

If the above fails because you're missing build dependencies and this is your own machine, try installing dependencies first. For Debian-based (e.g., Ubuntu) systems, this should work:

```sh
sudo apt build-dep python3
```

Typical additional (and optional) dependencies:

```sh
sudo apt install libssl-dev zlib1g-dev libbz2-dev liblzma-dev libreadline-dev libsqlite3-dev libffi-dev
```

Then rerun the `pyenv install 3.12.4` command again (Answer "yes" if prompted to continue because the version already exists).

### Setup "neovim" Python virtual environment

Create a Python virtual environment for Neovim:

```sh
pyenv virtualenv 3.12.4 neovim
```

Your Neovim Python virtual environment is now available at `~/.pyenv/versions/neovim`.

Whenever you want to make changes in this virtual environment, you first need to activate it in your current shell:

```sh
pyenv activate neovim
```

Correct activation  can be confirmed by running `pyenv which python` and `python --version`.

Next, install the Python packages you need for Neovim:

```sh
python -m pip install --upgrade pip
python -m pip install pynvim
```

To tell Neovim to use this virtual environment, add this near the top of your `init.lua`:

```lua
  vim.g.python3_host_prog = vim.env.HOME .. "/.pyenv/versions/neovim/bin/python"
```
