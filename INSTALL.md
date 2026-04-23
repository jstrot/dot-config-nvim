JST's Neovim Configuration -- Installation

# Make some space

Optional: If your home quota is limited, I suggest you move your whole `~/.local` directory to a different location that has more free space before proceeding further. For example:

```sh
cd ~
mv .local /auto/myws/local || mkdir /auto/myws/local
ln -s /auto/myws/local .local
```

For reference: At the time of this writing, my `~/.local/share/nvim/` is close to 600M.

# Clone the repository to setup your initial Neovim config

Before starting, if you already have a prior Neovim configuration directory (`~/.config/nvim`), you must move it aside first:

```sh
mv -T ~/.config/nvim ~/.config/nvim.bak
```

Clone:

```sh
git clone https://github.com/jstrot/dot-config-nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

# Neovim executable location

First, make sure you have a recent version of Neovim installed by picking one at <https://github.com/neovim/neovim/releases>.

> [!TIP]
> On Linux, the AppImage is the simplest to get going.
> Download it to your `~/bin` and link it with `ln -s ~/bin/nvim.appimage ~/bin/nvim`.

The Neovim executable is the one called named `nvim`!

# Nerd/Patched fonts

Enable support for Nerd/patched fonts.

It is highly recommended to install a patched font that contains extended characters for development (Icons for "bugs", "git", "GitHub", file types, ...). Many plugins rely on the availability of patched fonts.

The easy way is to download a font from https://www.nerdfonts.com/, install it in your OS (if you're running remotely over ssh, for example, that's the host running your terminal emulator!) and then enable that font in your terminal's configuration.

In general, if you're using a modern terminal emulator, you should choose a font that is a monospaced and has regular, bold, italic, and bold-italic variants (you'll find out the variants when you download it).
Some terminals may support emulating bold and italic, but it's better to have the actual font variants.

If your terminal supports it, you can also enable ligatures for a more pleasing experience.

A good starting point is to try the one I use, "FiraCode Nerd Font", a patched version of the "Fira Mono" font with programming ligatures and enlarged operators.
You can try out the different fonts here: https://www.programmingfonts.org/#firacode

## MacOS

### OS: MacOS

Run the "Font Book" application and use the "Install Font" button to add your Nerd font files (decompress the .zip!).

<!-- TODO: How to select the default monospace font? -->

### Terminal: iTerm2

<!-- TODO: How to select the font or the default? -->

## Windows

### OS: Windows

Copy the font files (decompress the .zip!) into the `C:/Windows/Fonts` directory.

<!-- TODO: How to select the default monospace font? -->

### Windows Terminal

<!-- TODO: How to select the font or the default? -->

## Linux

In most modern distributions, you can copy the font's .otf files (decompress the .zip!) to your `~/.local/share/fonts/` and run `fc-cache -f -v` to update the font cache.

It can also be added for all users copying to `/usr/local/share/fonts` as root and running `sudo fc-cache -f -v`.

Now applications can select the font (some applications may need to be restarted to see new fonts).

### Display Manager: Gnome

To make it the default monospace font, install and run the "Gnome Tweaks" application (`gnome-tweaks` package). Under the "Fonts" section, set "Monospace Text" to your Nerd font.

### Display Manager: KDE

<!-- TODO: How to select the default monospace font? -->

### Application: Gnome Terminal

Shift-Right-Click in Gnome Terminal, select the "Preferences" menu, then select a profile on the left (e.g., "Unnamed"). The font selection is under the "Text" tab.

If you made your Nerd font the default monotype font, just make sure the "Custom font" is unchecked.
Otherwise, or if you want to override the default size too, check the box and select your Nerd font.

### Application: Terminator

This is my preference as Terminator is written in Python around the libvte library (same as Gnome Terminal), has more options than Gnome Terminal, and is easily extensible with plugins.

Shift-Right-Click in Terminator, select the "Preferences" menu, then the "Profiles" tab, and select your profile (e.g., "default"). The font selection is under the "General" tab.

If you made your Nerd font the default monotype font, just make sure the "Use the system fixed width font" is checked.
Otherwise, or if you want to override the default size too, uncheck the box and select your Nerd font.

Supports true colors, but not ligatures.

### Application: Kitty

Kitty is a modern and fast terminal with great hardware acceleration support.

Here's my ~/.config/kitty/kitty.conf:

```
font_family      FiraCode Nerd Font Mono
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size 10.0

copy_on_select clipboard
map ctrl+shift+insert paste_from_buffer clipboard
strip_trailing_spaces smart
select_by_word_characters _
```

Supports true colors and ligatures.

### Example: xterm under VNC

<!-- TODO: What's needed here? Suggest a better setup too!! -->

## Not a Nerd?

If you can't or don't want to enable Nerd/patched fonts, make sure to set the `have_nerd_font` global variable to `false` by editing this line in your `init.lua`:

```lua
vim.g.have_nerd_font = false
```

# Terminal Colors

Most modern terminals are capable of displaying "true colors" (24-bit colors). Make sure your terminal is correctly configured and your `TERM` environment variable is appropriate. Sometimes that means using `TERM=xterm-256color` if that's all the system supports (see /usr/share/terminfo for available terminal types).

## Tmux True Color Support

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

# Shell alias

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

# Install Dependencies

## rg (ripgrep)

`rg` is a fast and efficient grep replacement. It is used in Neovim by the Telescope plugin for fuzzy finding.

On Debian-based systems, you can install it with:

```sh
sudo apt install ripgrep
```

## fd (fd-find)

`fd` is a fast and user-friendly alternative to `find`. It is used in Neovim by the Telescope plugin for enhanced file finding capabilities.

On Debian-based systems, you can install it with:

```sh
sudo apt install fd-find
```

# AI

## GitHub Copilot

Copilot requires nodeJS (`node`) version 20 or later.
If you don't have a compatible version installed, follow the instructions below.

You should not need anything from the official [GitHub Copilot Neovim instructions](https://github.com/github/copilot.vim).
The plugin is already available as `lua/plugins/Copilot.lua`.

All you need is to run `:Copilot auth` once within Neovim to link your account and set it up.

# Setup `node`

For tools that depend on "nodeJS", here's a quick installation method.

Install nvm (full instructions here: <https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating>):

```sh
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

Once installed and your shell is restarted, install the latest version of nodejs from <https://nodejs.org/en>:
```sh
$ nvm install --lts
$ nvm use --lts
$ node -v
v22.15.1
```
