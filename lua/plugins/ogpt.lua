-- https://github.com/huynle/ogpt.nvim
require('jst.ai.config')

local opts = {
  default_provider = (
    AI_is_ollama_enabled() and 'ollama'
    or AI_is_huggingface_enabled() and 'textgenui'
    or ''
  ),
  providers = {
    ollama = {
      api_host = AI_ollama_url() or '',
      api_key = AI_ollama_api_key() or '',
      model = AI_ollama_code_model() or '',
      api_params = {
        model = AI_ollama_code_model() or '',
        -- temperature = 0.8,
        -- top_p = 0.9,
      },
      api_chat_params = {
        model = AI_ollama_chat_model() or '',
        -- frequency_penalty = 0,
        -- presence_penalty = 0,
        -- temperature = 0.5,
        -- top_p = 0.9,
      },
    },
    openai= {
      api_host = AI_openai_nover_url() or '', -- ogpt appends "/v1/..."
      api_key = AI_openai_api_key() or '',
      api_params = {
        model = AI_openai_code_model() or '',
        -- temperature = 0.8,
        -- top_p = 0.9,
      },
      api_chat_params = {
        model = AI_openai_chat_model() or '',
        -- frequency_penalty = 0,
        -- presence_penalty = 0,
        -- temperature = 0.5,
        -- top_p = 0.9,
      },
    },
    textgenui = {
      api_host = AI_huggingface_url() or '',
      api_key = AI_huggingface_api_key() or '',
      api_params = {
        model = AI_huggingface_code_model() or '',
        -- temperature = 0.8,
        -- top_p = 0.9,
      },
      api_chat_params = {
        model = AI_huggingface_chat_model() or '',
        -- frequency_penalty = 0,
        -- presence_penalty = 0,
        -- temperature = 0.5,
        -- top_p = 0.9,
      },
    },
  },
  edgy = true, -- enable this. See lua/plugins/edgy.lua for options
  single_window = false, -- set this to true if you want only one OGPT window to appear at a time
  edit = {
    diff = false,
    keymaps = {
      close = "q", -- "<C-c>",
      accept = "<C-y>", -- "<M-CR>",
      toggle_diff = "<C-d>",
      toggle_parameters = "<C-p>", -- "<C-o>",
      cycle_windows = nil, -- "<Tab>",
      use_output_as_input = "<C-u>",
    },
  },
  chat = {
    keymaps = {
      close = "q", -- { "<C-c>" },
      yank_last = "<C-y>",
      yank_last_code = "<C-i>",
      scroll_up = "<C-u>",
      scroll_down = "<C-d>",
      new_session = "<C-n>",
      cycle_windows = "<Tab>",
      cycle_modes = "<C-f>",
      next_message = "J",
      prev_message = "K",
      select_session = "<CR>",
      rename_session = "r",
      delete_session = "d",
      draft_message = "<C-d>",
      edit_message = "e",
      delete_message = "d",
      toggle_parameters = "<C-p>", -- "<C-o>",
      toggle_message_role = "<C-r>",
      toggle_system_role_open = "<C-s>",
      stop_generating = "<C-x>",
    },
  },


}
-- For debugging: OGPT_opts=opts
return {
  {
    "huynle/ogpt.nvim",
    enabled = opts.default_provider ~= '',
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "folke/edgy.nvim",
    },
    opts = opts,
    cmd = {
      'OGPT',
      'OGPTActAs',
      'OGPTCompleteCode',
      'OGPTFocus',
      'OGPTRun',
      'OGPTRunWithOpts',
    },
    keys = {
      { mode="n", "<leader>cc<cr>", "<cmd>OGPT<cr>", desc = "Run OGPT [C]hat" },
    },
  }
}

-- vim: sw=2 et
