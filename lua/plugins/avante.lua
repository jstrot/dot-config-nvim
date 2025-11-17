-- https://github.com/yetone/avante.nvim
require('jst.ai.config')

local function avante_shortcuts()
  -- Prompts are used with "#<promptname>" in Avante sessions
  local prompts_dirs = {
    ".github/prompts",
  }
  local shortcuts = {
    -- {
    --   name = "refactor",
    --   description = "Refactor code with best practices",
    --   details = "Automatically refactor code to improve readability, maintainability, and follow best practices while preserving functionality",
    --   prompt = "Please refactor this code following best practices, improving readability and maintainability while preserving functionality."
    -- },
    -- {
    --   name = "test",
    --   description = "Generate unit tests",
    --   details = "Create comprehensive unit tests covering edge cases, error scenarios, and various input conditions",
    --   prompt = "Please generate comprehensive unit tests for this code, covering edge cases and error scenarios."
    -- },
    -- Add more custom shortcuts, preferably using prompts_dir above.
  }
  for _, prompts_dir in ipairs(prompts_dirs) do
    if vim.fn.isdirectory(prompts_dir) == 1 then
      local files = vim.fn.glob(prompts_dir .. "/*.md", false, true)
      for _, filepath in ipairs(files) do
        local content = vim.fn.readfile(filepath)
        if #content > 0 then
          local promptname = vim.fn.fnamemodify(filepath, ":t:r")
          promptname = promptname:gsub("%.prompt$", "")
          local description = content[1]
          local prompt = table.concat(content, "\n")
          table.insert(shortcuts, {
            name = promptname,
            description = description,
            prompt = prompt,
          })
        end
      end
    end
  end
  return shortcuts
end

return {
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    --  must add this setting! ! !
    build = (vim.fn.has("win32") ~= 0
             and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
             or "make"),
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    enabled = vim.g.agentic_mode_plugin == 'avante',
    opts = {
      -- disabled_tools = {
      --   'str_replace',
      -- },
      mode = "agentic",
      instructions_file = (function()
        local instruction_files = {
          "AGENTS.md",
          -- Directory not supported yet! ".github/instructions/", -- ".github/instructions/**/NAME.instructions.md",
          ".github/copilot-instructions.md",
          "avante.md",
        }
        for _, file in ipairs(instruction_files) do
          if vim.fn.filereadable(file) == 1 then
            return file
          end
        end
        return nil -- fallback to avante's default
      end)(),
      provider = (
        AI_is_copilot_active() and "copilot"
        or AI_is_ollama_enabled() and "ollama"
        or nil),
      -- TODO: override_prompt_dir = vim.fn.expand("~/.config/nvim/avante_prompts"),
      auto_suggestions_provider = (
        (vim.g.auto_suggest_completion_plugin == 'avante')
        and (
          AI_is_ollama_enabled() and "ollama_suggest"
        )
      ) or nil,
      providers = {
        copilot = {
          model = AI_copilot_agent_model(), -- `:AvanteModels` to pick or list of models
          -- extra_request_body = {
          --   max_tokens = 128000,
          -- },
          -- timeout = 30000, -- Timeout in milliseconds
          -- default: context_window = 64000, -- Number of tokens to send to the model for context
          -- claude-sonet-4.5 default: context_window = 128000, -- Number of tokens to send to the model for context
          context_window = 200000, -- Number of tokens to send to the model for context
          -- extra_request_body = {
          --   temperature = 0.75,
          --   max_tokens = 20480,
          -- },
        },
        ollama = {
          endpoint = AI_ollama_url(),
          model = AI_ollama_agent_model(), -- must be filled in, `:AvanteModels` won't provide a list
        },
        ollama_suggest = {
          __inherited_from = 'ollama',
          model = AI_copilot_code_model(),
        },
      },
      behaviour = {
        auto_suggestions = vim.g.auto_suggest_completion_plugin == 'avante', -- WARN: Copilot rate and debouncing by Avante can lead to account freeze, do not enable for Copilot!
        auto_focus_sidebar = true,
        auto_approve_tool_permissions = true, -- automatically approve all tool permissions requests
        -- auto_approve_tool_permissions = false, -- Show permission prompts for all tools
        -- auto_approve_tool_permissions = { "bash", "replace_in_file" }, -- Auto-approve specific tools only
        auto_set_keymaps = true,
      },
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          -- https://ravitemer.github.io/mcphub.nvim/extensions/avante.html
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
      selector = {
        provider = (
          (vim.g.picker_plugin == 'snacks.picker' and 'snacks' or
          (vim.g.picker_plugin == 'telescope' and 'telescope' or
          "native"
        ))),
        -- provider_opts = {},
      },
      input = {
        provider = (
          (vim.g.picker_plugin == 'snacks.picker' and 'snacks' or
          (vim.g.picker_plugin == 'telescope' and 'telescope' or
          (vim.g.picker_plugin == 'fzf-lua' and 'fzf' or
          "native"
        )))),
        provider_opts = {
          -- Additional snacks.input options
          title = "Avante Input",
          icon = "󰵰",
          -- placeholder = "Enter your API key...",
        },
      },
      selection = {
        -- enabled = true,
        hint_display = "none", -- "delayed" | "none"
      },
      windows = {
        position = "right", -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        edit = {
          -- border = "rounded",
          -- start_insert = true, -- Start insert mode when opening the edit window
        },
        ask = {
          -- floating = false, -- Open the 'AvanteAsk' prompt in a floating window
          start_insert = false, -- Start insert mode when opening the ask window
          -- border = "rounded",
          -- ---@type "ours" | "theirs"
          -- focus_on_apply = "ours", -- which diff to focus after applying
        },
      },
      mappings = {
        -- See defaults in ~/.local/share/nvim/lazy/avante.nvim/lua/avante/config.lua
        -- Add assignments around `if Config.behaviour.auto_set_keymaps` in ~/.local/share/nvim/lazy/avante.nvim/lua/avante/init.lua
        toggle = {
          suggestion = nil, -- Default of '<leader>as'. Using copilot for auto-suggestions, not Avante
        },
        suggestion = {
          -- Adjusted key mappings to match the Tim Pope's official Copilot plugin
          accept = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        sidebar = {
          apply_all = 'ga', -- Default 'A' is insane!
          switch_windows = '<C-Down>', -- Default of '<Tab>'  interferes with copilot
          reverse_switch_windows = '<C-Up>', -- To match switch_windows
        },
        files = {
          add_current = "<leader>ab", -- Defaults to '<leader>ac' Add current buffer to selected files
          add_all_buffers = "<leader>aB", -- Add all buffer files to selected files
        },
        select_model = '<leader>am',
      },
      shortcuts = avante_shortcuts(),
      acp_providers = {
        ["gemini-cli"] = {
          command = "gemini",
          args = { "--experimental-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
          },
        },
        ["claude-code"] = {
          command = "npx",
          args = { "@zed-industries/claude-code-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
          },
        },
        ["goose"] = {
          command = "goose",
          args = { "acp" },
        },
        ["codex"] = {
          command = "codex-acp",
          env = {
            NODE_NO_WARNINGS = "1",
            OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
          },
        },
      },
    },
    dependencies = {

      vim.g.cmp_plugin == "nvim-cmp" and "hrsh7th/nvim-cmp" or {}, -- autocompletion for avante commands and mentions
      -- FIXME: window id errors after windows were closed with Avante active: vim.g.cmp_plugin == "blink.cmp" and "Saghen/blink.cmp" or {}, -- autocompletion for avante commands and mentions
      -- FIXME: window id errors after windows were closed with Avante active: vim.g.cmp_plugin == "blink.cmp" and "Kaiser-Yang/blink-cmp-avante" or {}, -- Avante source for blink.cmp

      vim.g.picker_plugin == 'fzf-lua' and "ibhagwan/fzf-lua" or {}, -- for file_selector provider fzf
      vim.g.picker_plugin == 'telescope' and "nvim-telescope/telescope.nvim" or {}, -- for file_selector provider telescope
      vim.g.picker_plugin == 'snacks.picker' and "folke/snacks.nvim" or {}, -- for input provider snacks

      AI_is_copilot_enabled() and ( -- For provider copilot
        (vim.g.auto_suggest_completion_plugin == 'copilot-lua') and "zbirenbaum/copilot.lua"
        or (vim.g.auto_suggest_completion_plugin == 'copilot') and "github/copilot.vim"
        or "github/copilot.vim" -- Default
      ) or nil,

      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "HakonHarnes/img-clip.nvim",
      -- {
      --   -- Make sure to set this up properly if you have lazy=true
      --   'MeanderingProgrammer/render-markdown.nvim',
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
    keys = {
      -- { "<leader>cca<cr>", "<cmd>AvanteToggle<cr>", mode = "n", desc = "Toggle Avante" },
      -- { "<leader>ccaa",    "<cmd>AvanteAsk<cr>",    mode = "n", desc = "Avante [A]sk" },
      -- { "<leader>ccab",    "<cmd>AvanteBuild<cr>",  mode = "n", desc = "Avante [B]uild" },
      -- { "<leader>ccac",    "<cmd>AvanteChat<cr>",   mode = "n", desc = "Avante [C]hat" },
    },
    config = function(_, opts)
      local avante = require('avante')
      avante.setup(opts)

      -- Avante usually uses Neovim tools to modify files in place so should
      -- not be causing "changed since editing started" prompts. If it does
      -- modify outside of Neovim, it should not break the AI session itself.
      -- It the occasional prompt is annoying, or it slows down your AI
      -- workflow, enable autoread.
      if false then
        vim.o.autoread = true
      end
    end,
  },
}
-- vim: sw=2 et
