JST's Neovim Configuration -- Troubleshooting

# Invalid node type "delimiter"

Example error:

    Error executing lua: ...m-0.10.0/share/nvim/runtime/lua/vim/treesitter/query.lua:252: Query error at 2:4. Invalid node type "delimiter"

This error can be seen when running an upgraded version Neovim which is incompatible with the current compiled Treesitter parsers.
For example, you may encounter this when running a `:help` command.

To fix this, request that Treesitter recompiles its parsers:

```vim
:TSUpdateSync
```

Then restart Neovim. If you're stuck in the help window and the error keeps popping up, execute `:q` to close the help window.


