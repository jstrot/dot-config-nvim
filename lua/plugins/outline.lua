-- https://github.com/hedyhli/outline.nvim
return {
  {
    "hedyhli/outline.nvim",
    opts = {
    },
    config = function(_, opts)
      require("outline").setup(opts)

      vim.keymap.set("n", "<leader>to", "<cmd>Outline<CR>", { desc = "[T]oggle [O]utline" })
    end,
  },
}

-- vim: sw=2 et
