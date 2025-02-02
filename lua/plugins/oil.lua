-- https://github.com/stevearc/oil.nvim
local file_info_columns_displayed = false
local min_columns = {
  "icon",
}
local all_columns = {
  "icon",
  "permissions", -- not default
  "size",        -- not default
  "mtime",       -- not default
}
local function toggle_file_info_columns()
  file_info_columns_displayed = not file_info_columns_displayed
  require("oil").set_columns(file_info_columns_displayed and all_columns or min_columns)
end
return {
  {
    "stevearc/oil.nvim",
    -- event = 'VeryLazy',  lazy-loading would break `nvim .`
    dependencies = {
      -- 'echasnovski/mini.icons',
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      columns = file_info_columns_displayed and all_columns or min_columns,
      buf_options = {
        buflisted = true,        -- default: false
        bufhidden = "",          -- default: "hide"
      },
      watch_for_changes = false, -- default: true
      view_options = {
        show_hidden = true,      -- default: false
        -- default: natural_order = "fast",
        -- default: case_insensitive = false,
      },
      -- Align keymaps with Telescope
      -- use_default_keymaps = true,  -- Don't disable unless you list all keymaps
      keymaps = {
        ["<leader>?"] = { -- default: "g?",
          "actions.show_help",
        },
        ["<C-v>"] = { -- default: "<C-s>"
          "actions.select",
          opts = { vertical = true },
          desc = "Open the entry under the cursor { vertical = true }",
        },
        ["<C-x>"] = { -- default: "<C-h>"
          "actions.select",
          opts = { horizontal = true },
          desc = "Open the entry under the cursor { horizontal = true }",
        },
        ["<leader>tI"] = {
          toggle_file_info_columns,
          desc = "[T]oggle file [I]nformation columns",
        },
      },
    },
  },
}

-- vim: sw=2 et
