-- https://github.com/ibhagwan/fzf-lua
return {
  {
    "ibhagwan/fzf-lua",
    enabled = vim.g.picker_plugin == 'fzf-lua',
    event = 'VeryLazy',
    branch = "main",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      local fzflua = require("fzf-lua")
      fzflua.register_ui_select()
    end,
  }
}

-- vim: sw=2 et
