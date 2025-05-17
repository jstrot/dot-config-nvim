-- https://github.com/rcarriga/nvim-notify
return {
  {
    "rcarriga/nvim-notify",
    config = function(_, opts)
      vim.notify = require("notify")
    end,
  },
}

-- vim: sw=2 et
