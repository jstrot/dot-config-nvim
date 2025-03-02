-- https://github.com/hedyhli/outline.nvim
return {
  {
    "hedyhli/outline.nvim",
    opts = {
    },
    cmd = {
      'Outline',
      'OutlineClose',
      'OutlineFocus',
      'OutlineFocusCode',
      'OutlineFocusOutline',
      'OutlineFollow',
      'OutlineOpen',
      'OutlineRefresh',
      'OutlineStatus',
    },
    keys = {
      { "<leader>to", "<cmd>Outline<CR>", desc = "[T]oggle [O]utline" },
    },
  },
}

-- vim: sw=2 et
