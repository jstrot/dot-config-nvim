-- https://github.com/rcarriga/nvim-notify
return {
  {
    "rcarriga/nvim-notify",
    opts = {
      -- Highlight group 'NotifyBackground' has no background highlight
      -- Please provide an RGB hex value or highlight group with a background value for 'background_colour' option.
      -- This is the colour that will be used for 100% transparency.
      background_colour = "#000000",
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
}

-- vim: sw=2 et
