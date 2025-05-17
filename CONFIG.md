JST's Neovim Configuration -- Configuration

# Configuration language and init file

Vim's configuration language is "Vimscript".
Neovim's configuration language is "Lua".

Vimscript is still available but Lua is much more powerful.

Neovim's main configuration file is:

    ~/.config/nvim/init.lua

Other Lua files are contained under this directory:

    ~/.config/nvim/lua/

# Basic configuration files structure

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
│       ├── blink.cmp.lua
│       ├── CopilotChat.lua
│       ├── Copilot.lua
│       ├── fzf.lua
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
# The main init.lua

The init.lua sets up your default variables, loads plugins and configs.

In this repository, the main init.lua file is based on the one from the [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) project as well as customizations from myself, [Jean-Sébastien Trottier (JST)](mailto:jst@qualipsoft.com). The kickstart plugins are moved to individual directories to ease maintenance and sharing and many more are added.

Feel free to modify all of this to your liking. Remember, it's your **PDE**!


# Advanced Configuration

## Python venv for Neovim

Setting up a Python virtual environment for Neovim to use is a good idea to keep your Neovim Python dependencies separate from your system Python dependencies.

### Install pyenv (if you don't have it yet)

I strongly suggest you install `pyenv` to manage your Python versions and `pyenv-virtualenv` to manage your Python virtual environments. Both get installed automatically by this script (see https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer for details):

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

Next, install a recent Python 3 version (According to https://www.python.org/downloads/, 3.12.4 is the latest bug fix release as of this writing):

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

To tell Neovim to use this virtual environment, the Vim `python3_host_prog`
global variable must be set. In `init.lua` there's this is already done if
the default virtual environment is found but you can point it elsewhere if you
like.

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

## Images support

### Kitty

Kitty is great terminal emulator with many features. One of those features is the "Kitty Graphics Protocol" to allow displaying images in your "text" terminal.

Some other terminal applications like Konsole, wayst and WezTerm also off some support for the Kitty Graphics Protocol but Kitty is the recommended one.

### Tmux

See the included tmux.con file. Amongst other things, it enable "allow-passthrough" so terminal protocol extensions, like the "Kitty Graphics Protocol" can be used.

The following can be added to your ~/.tmux.conf or ~/.config/tmux/config:

```
source ~/.config/nvim/tmux.conf
```
