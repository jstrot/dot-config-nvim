-- https://github.com/olimorris/codecompanion.nvim
require('jst.ai.config')

if vim.g.github_copilot_enabled and vim.g.github_copilot_active and not vim.g.auto_suggest_completion_plugin then
  vim.g.auto_suggest_completion_plugin = 'codecompanion'
end

-- `gh` command required for githubmodels
-- if vim.g.auto_suggest_completion_plugin == 'codecompanion' then
--   if vim.fn.executable('gh') == 0 then
--     -- Default `gh` to `git xos gh`
--     vim.env.PATH = vim.env.PATH .. ':/nfs/acmecontrol/control/github/gh-cli/bin/'
--   end
-- end

return {
  {
    "olimorris/codecompanion.nvim",
    enabled = (
      vim.g.agentic_mode_plugin == 'codecompanion'
      or vim.g.auto_suggest_completion_plugin == 'codecompanion'
    ),
    cond = vim.g.auto_suggest_completion_plugin == 'codecompanion',
    priority = 45, -- default is 50, 45 is the preferred auto-suggest completion plugin, others are 40
    -- event = 'VeryLazy' | 'InsertEnter', -- Does not load on command-line files until `:e` ???
    -- event = { "BufReadPre", "BufNewFile" },
    event = "InsertEnter", -- TODO:

    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      -- TODO: "HakonHarnes/img-clip.nvim",
      -- TODO: "echasnovski/mini.diff",
    },
    opts = {
      strategies = {
        chat = {
          -- adapter = 'copilot',
          adapter = 'copilot/claude-sonet-4.5',
          keymaps = {
            send = { modes = { n = { "<C-s>", "<cr>", }, i = "<C-s>", }, opts = { }, },
            close = { modes = { n = "<C-c>", i = "<C-c>", }, opts = { }, },
            -- Add further custom keymaps here
          },
          opts = {
            completion_provider = (
              (vim.g.cmp_plugin == "blink.cmp" and "blink" or
              (vim.g.cmp_plugin == "nvim-cmp" and "cmp" or
                "default"
              ))),
          }
        },
        inline = {
          adapter = "copilot",
          keymaps = {
            accept_change = { modes = { n = "ga", }, description = "Accept the suggested change", },
            reject_change = { modes = { n = "gr", }, description = "Reject the suggested change", },
          },
        },
        cmd = {
          adapter = "copilot",
        }
      },
      adapters = {
        ['copilot/claude-sonet-4.5'] = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4.5",
              },
            },
          })
        end,
      },
      language = "English",
      log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO
      display = {
        inline = {
          layout = "vertical", -- How opening an inline prompt creates new buffers? vertical|horizontal|buffer
        },
        action_palette = {
          provider = (
            (vim.g.picker_plugin == 'snacks.picker' and 'snacks' or
            (vim.g.picker_plugin == 'telescope' and 'telescope' or
            "default"
          ))),
        }
      },
      memory = {
        opts = {
          chat = {
            enabled = true,
          },
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          }
        }
      }
    },
    -- TODO: File types?
  }
}

-- vim: sw=2 et
