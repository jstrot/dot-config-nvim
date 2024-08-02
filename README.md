JST's Neovim Configuration

Hi, I'm [Jean-Sébastien Trottier](jst@qualipsoft.com), owner of qualIP Software and Tech Lead at Cisco, working on the IOS-XR platform.
This is my Neovim configuration.


# Introduction

Let's get things straight:
Neovim is not an **IDE**, it's a **text editor**!
Neovim is a fork of Vim that focuses on extensibility and usability.

But it's not like any other *configurable* text editor like Sublime Text, Atom, or VS Code.
Neovim is highly extensible using the Lua programming language. This means that you are not limited to the features provided by the core editor or a predetermined set of configurations in a JSON file.

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

## Make some space

Optional: If your home quota is limited I suggest you move your whole `~/.local` directory to a different location that has more free space before proceeding further. For example:

```sh
cd ~
mv .local /auto/myws/local || mkdir /auto/myws/local
ln -s /auto/myws/local .local
```

For reference: At the time of this writing, my `~/.local/share/nvim/` is close to 600M.

## Clone the repository to setup your initial Neovim config

Before starting, if you already have a prior Neovim configuration directory (`~/.config/nvim`), you must move it aside first:

```sh
mv -T ~/.config/nvim ~/.config/nvim.bak
```

Clone:

```sh
git clone https://github.com/jstrot/dot-config-nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

## Neovim executable location

First, make sure you have a recent version of Neovim installed by picking one at <https://github.com/neovim/neovim/releases>.

> [!TIP]
> On Linux, the AppImage is the simplest to get going.
> Download it to your `~/bin` and link it with `ln -s ~/bin/nvim.appimage ~/bin/nvim`.

The Neovim executable is the one called named `nvim`!

## Nerd/Patched fonts

Enable support for Nerd/patched fonts.

It is highly recommended to install a patched font that contains extended characters for development (Icons for "bugs", "git", "GitHub", file types, ...). Many plugins rely on the availability of patched fonts.

The easy way is to download a font from Mhttps://www.nerdfonts.com/>, install it in your OS (if you're running remotely over ssh, for example, that's the host running your terminal emulator!) and then enable that font in your terminal's configuration. A good starting point is to try the one I use, "DroidSansM Nerd Font Mono", a patched version of the "Droid Sans Mono" which has fairly square letters and scalable to small sizes without issues. Just make sure to use a "Mono" variant.

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

Shift-Right-Click in Gnome Terminal, select the "Preferences" menu, then select a profile on the left (e.g., "Unnamed"). The font selection is under the "Text" tab.

If you made your Nerd font the default monotype font, just make sure the "Custom font" is unchecked.
Otherwise, or if you want to override the default size too, check the box and select your Nerd font.

#### Application: Terminator

This is my preference as Terminator is written in Python, has more options than Gnome Terminal, and is easily extandable with plugins.

Shift-Right-Click in Terminator, select the "Preferences" menu, then the "Profiles" tab, and select your profile (e.g., "default"). The font selection is under the "General" tab.

If you made your Nerd font the default monotype font, just make sure the "Use the system fixed width font" is checked.
Otherwise, or if you want to override the default size too, uncheck the box and select your Nerd font.

#### Example: xterm under VNC

<!-- TODO: What's needed here? Suggest a better setup too!! -->

### Not a Nerd?

If you can't or don't want to enable Nerd/patched fonts, make sure to set the `have_nerd_font` global variable to `false` by editing this line in your `init.lua`:

```lua
vim.g.have_nerd_font = false
```

## Terminal Colors

Most modern terminals are capable of displaying "true colors" (24-bit colors). Make sure your terminal is correctly configured and your `TERM` environment variable is appropriate. Sometimes that means using `TERM=xterm-256color` if that's all the system supports (see /usr/share/terminfo for available terminal types).

### Tmux True Color Support

The following tmux configuration (`~/.config/tmux/config` or `~/.tmux.conf`) works well for me using Terminator running on Ubuntu, connected over `ssh` (latest `mosh` client & server, actually) and running `tmux` on my RHEL8 server:

```
# Enable true color support
#set-option -g default-terminal "tmux-direct"  # Not on RHEL8
#set-option -g default-terminal "tmux-256color"  # Not on RHEL8
set-option -g default-terminal "screen-256color"

# If using mosh, make sure it is >1.3.2 or build from git HEAD on both client and server
set-environment -g COLORTERM "truecolor"
set-environment -g COLORFGBG "15;0"

# https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-rgb-colour
set-option -ag terminal-overrides ",tmux-direct:Tc"
set-option -ag terminal-overrides ",*-256color:Tc"
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

## Shell alias

Suggestions to make Neovim your default editor:

Add this to your rc files, preferably to your main profile rc file (`~/.profile`) which gets sources by Display Managers.

```sh
export EDITOR=nvim
```

Make sure your shell's own profile rc (`~/.bashrc`, `~/.zprofile`, ...) sources `~/.profile` so it gets loaded in remote login sessions too.

In the interactive part of your rc files (`~/.bashrc`, `~/.zshrc`, `~/.bash_aliases`, ...), add an alias:

```sh
alias vi=nvim
```


# Cheatsheet

See this cheatsheet for a quick reference to the keymaps and commands available in this configuration: [Cheatsheet](./CHEATSHEET.md)


# Troubleshooting

## `Error executing lua: ...m-0.10.0/share/nvim/runtime/lua/vim/treesitter/query.lua:252: Query error at 2:4. Invalid node type "delimiter"`

This error can be seen when running an upgraded version Neovim which is incompatible with the current compiled Treesitter parsers.
For example, you may encounter this when running a `:help` command.

To fix this, request that Treesitter recompiles its parsers:

```vim
:TSUpdateSync
```

Then restart Neovim. If you're stuck in the help window and the error keeps popping up, execute `:q` to close the help window.


# Advanced Configuration

## Python venv for Neovim

Setting up a Python virtual environment for Neovim to use is a good idea to keep your Neovim Python dependencies separate from your system Python dependencies.

### Install pyenv (if you don't have it yet)

I strongly suggest you install `pyenv` to manage your Python versions and `pyenv-virtualenv` to manage your Python virtual environments. Both get installed automatically by this script (see <https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer> for details):

```sh
curl https://pyenv.run | bash
```

This will install pyenv in your home directory (`~/.pyenv`).

Optional: If your home quota is limited, I suggest you move this to a different location that has more free space before proceeding further. For example:

```sh
cd ~
mv .pyenv /auto/myws/pyenv
ln -s /auto/myws/pyenv .pyenv
```

In the interactive part of your rc files (`~/.bashrc`, `~/.zshrc`), add this:

```sh
# https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer
if [ -d "${PYENV_ROOT:-$HOME/.pyenv}" ] ; then
    export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
    [ -d $PYENV_ROOT/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
```

Restart your shell or run the above code inline to activate the changes.

Next, install a recent Python 3 version (According to <https://www.python.org/downloads/>, 3.12.4 is the latest bug fix release as of this writing):

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


## Extra Tools

### `ruff` -- An extremely fast Python linter and code formatter, written in Rust.

#### Install using Mason

The Mason Neovim plugin can manage your installation of tools, making it easy to add, update, remove.

Within Neovim, run:
```
:MasonInstall ruff
```

The above will create a Python virtual environment in `~/.local/share/nvim/mason/packages/ruff/venv`

#### Install in Neovim's Python virtual environment

Assuming you've setup a Python virtual environment as described above, here is the suggested approach:

```sh
# Activate Neovim's Python virtual environment
pyenv activate neovim
# or
source ~/.pyenv/versions/neovim/bin/activate

# Install ruff
pip install ruff

# Deactivate the Python virtual environment
deactivate
```

#### Using from the command-line

If you want to use `ruff` from the command-line as well, the easy way is to link the executable within the Python virtual environment from you `~/bin` directory:

```sh
cd ~/bin

ln -s ~/.local/share/nvim/mason/packages/ruff/venv/bin/ruff
# or
ln -s ~/.pyenv/versions/neovim/bin/ruff
```
