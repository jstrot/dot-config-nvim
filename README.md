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


# Installation

Please see the [installation](./INSTALL.md) guide.

# Getting started with Neovim

For newbies and seasoned veterans alike, these are great starting points to enhance your Neovim experience:

- kickstart.nvim's (TJ DeVries's) [The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)
- Run the tutorial within Neovim: `:Tutor`
- Read the configs and explanations in `~/.config/nvim/init.lua`

# Configuration

Please see the [configuration](./CONFIG.md) guide.

# Cheatsheet

See this cheatsheet for a quick reference to the keymaps and commands available in this configuration: [Cheatsheet](./CHEATSHEET.md)


# Troubleshooting

Please see the [troubleshooting](./TROUBLESHOOTING.md) guide.
