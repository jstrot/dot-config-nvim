-- https://github.com/obsidian-nvim/obsidian.nvim
-- Formerly: https://github.com/epwalsh/obsidian.nvim

-- Populate your workspace list to enable:
local workspaces = {
  -- Example:
  -- {
  --   name = "Personal",
  --   path = "~/Documents/Obsidian Vault",
  -- },
}

return {
  {
    'obsidian-nvim/obsidian.nvim',
    enabled = #workspaces > 0, -- Opt-in feature; Add workspaces below
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- Optional.
      'hrsh7th/nvim-cmp',  -- Recommended
      'nvim-telescope/telescope.nvim',  -- Recommended
      -- 'echasnovski/mini.pick',  -- Alternate to telescope
      -- 'ibhagwan/fzf-lua',  -- Alternate to telescope
      -- 'nvim-treesitter/nvim-treesitter',  -- Recommended but I use Markview
      -- 'preservim/vim-markdown',  -- Alternate to Treesiter/Markview
      -- 'epwalsh/pomo.nvim',  -- TODO:
    },

		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "notes/dailies",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%B %-d, %Y",
			-- Optional, default tags to add to each new daily note created.
			default_tags = { "daily-notes" },
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = 'daily.md',
		},

		-- -- Optional, customize how note IDs are generated given an optional title.
		-- ---@param title string|?
		-- ---@return string
		-- note_id_func = function(title)
		-- 	-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- 	-- In this case a note with the title 'My new note' will be given an ID that looks
		-- 	-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
		-- 	local suffix = ""
		-- 	if title ~= nil then
		-- 		-- If title is given, transform it into valid file name.
		-- 		suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		-- 	else
		-- 		-- If title is nil, just add 4 random uppercase letters to the suffix.
		-- 		for _ = 1, 4 do
		-- 			suffix = suffix .. string.char(math.random(65, 90))
		-- 		end
		-- 	end
		-- 	return tostring(os.time()) .. "-" .. suffix
		-- end,

    opts = {
      workspaces = workspaces,
      checkbox = {
        order = { " ", "/", "x", "-", "<", ">" },
      },
      -- checkboxes = { ... }, -- NOTE: I use markview for Markdown formatting and its syntax highlighting so not overriding checkboxes here.
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d", -- "%Y-%m-%d-%a"
        time_format = "%H:%M",
      },
      ui = {
        -- Obsidian additional syntax features require 'conceallevel' to be set to 1 or 2
        -- See https://github.com/epwalsh/obsidian.nvim/issues/286 for more details.
        -- If you don't want Obsidian's additional UI features, you can disable them and suppress this warning by setting 'ui.enable = false' in your Obsidian nvim config.
        enable = false,
      },
      completion = {
        nvim_cmp = vim.g.cmp_plugin == 'nvim-cmp',
        blink = vim.g.cmp_plugin == 'blink.cmp',
        min_chars = 2, -- Trigger completion at N chars.
        -- Set to false to disable new note creation in the picker
        create_new = true,
      },
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
        -- (vim.g.picker_plugin == "fzf-luz" and 'fzf-lua') or
        -- (vim.g.picker_plugin == "mini.pick" and 'mini.pick') or
        name = (
          vim.g.picker_plugin == "telescope" and 'telescope.nvim'
          or vim.g.picker_plugin == "snacks.picker" and 'snacks.pick'
          or 'telescope.nvim' -- default
        ),
        note_mappings = {
          new = "<C-x>",
          insert_link = "<C-l>",
        },
        tag_mappings = {
          tag_note = "<C-x>",
          insert_tag = "<C-l>",
        },
      },
			legacy_commands = false, -- https://github.com/obsidian-nvim/obsidian.nvim/wiki/Commands
    },
    cmd = {
      'Obsidian',
    },
    keys = {
      { '<leader>ot', '<cmd>Obsidian today<cr>', desc = "[O]pen [T]oday's note" },
      { '<leader>oy', '<cmd>Obsidian yesterday<cr>', desc = "[O]pen [Y]esterday's note" },
      { '<leader>oT', '<cmd>Obsidian tomorrow<cr>', desc = "[O]pen [T]omorrow's note" },
      { '<leader>sod', '<cmd>Obsidian dailies -35 1<cr>', desc = "[S]earch [O]bsidian [D]ailies" },
      { '<leader>sof', '<cmd>Obsidian quick_switch<cr>', desc = "[S]earch [O]bsidian [F]iles/notes" },
      { '<leader>sog', '<cmd>Obsidian search<cr>', desc = "[S]earch [O]bsidian [G]rep in notes" },
      { '<leader>sov', '<cmd>Obsidian workspace<cr>', desc = "[S]earch [O]bsidian [V]aults/workspaces" },
    },
    config = function(_, opts)
      local obsidian = require('obsidian')
      obsidian.setup(opts)

      -- https://github.com/obsidian-nvim/obsidian.nvim/wiki/Keymaps

      vim.api.nvim_create_autocmd("User", {
        pattern = "ObsidianNoteEnter",
        callback = function(ev)

          -- match lua/plugins/bullets.lua. default = "<leader>ch"
          vim.keymap.set("n", "<leader>x", "<cmd>Obsidian toggle_checkbox<cr>", { buffer = ev.buf, desc = "Toggle checkbox", })
          vim.keymap.set("n", "<m-cr>", function()
            local action = require("obsidian").util.smart_action()
            local keys = vim.api.nvim_replace_termcodes(action, true, false, true)
            vim.api.nvim_feedkeys(keys, "n", false)
          end, { buffer = ev.buf, desc = "Toggle checkbox", })

          -- FIXME: Errors: vim.keymap.set("n", "gf", obsidian.util.gf_passthrough, { buffer = ev.buf, noremap = false, expr = true, })

        end,
      })

      if true then
      -- Smart action depending on context, either follow link or toggle checkbox.
      -- ["<cr>"] = { -- TODO: Maybe use something like `gF`?
      --   action = function()
      --     return require("obsidian").util.smart_action()
      --   end,
      --   opts = { buffer = true, expr = true },
      -- }
      vim.api.nvim_create_autocmd("User", {
        pattern = "ObsidianNoteEnter",
        callback = function(ev)
          vim.keymap.del("n", "<CR>", { buffer = ev.buf })
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "ObsidianNoteEnter",
        callback = function(ev)
          vim.keymap.set("n", "<leader>oa", require("obsidian").util.smart_action, { buffer = ev.buf, expr = true, desc = "[O]bsidian smart [A]ction" })
        end,
      })
      end

    end,
  }
}

-- vim: sw=2 et
