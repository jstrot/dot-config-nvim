-- https://github.com/huynle/ogpt.nvim
require('config.ai')
local opts = {
  default_provider = (jst_get_secret(vim.g.ollama_url_env, vim.g.ollama_url_file) and 'ollama') or (jst_get_secret(vim.g.huggingface_url_env, vim.g.huggingface_url_file) and 'textgenui') or '',
  providers = {
    ollama = {
      api_host = jst_get_secret(vim.g.ollama_url_env, vim.g.ollama_url_file) or '',
      api_key = jst_get_secret(vim.g.ollama_token_env, vim.g.ollama_token_file) or '',
      model = jst_get_secret(vim.g.ollama_code_model_env, vim.g.ollama_code_model_file) or vim.g.ollama_code_model or '',
      api_params = {
        model = jst_get_secret(vim.g.ollama_code_model_env, vim.g.ollama_code_model_file) or vim.g.ollama_code_model or '',
        -- temperature = 0.8,
        -- top_p = 0.9,
      },
      api_chat_params = {
        model = jst_get_secret(vim.g.ollama_chat_model_env, vim.g.ollama_chat_model_file) or vim.g.ollama_chat_model or '',
        -- frequency_penalty = 0,
        -- presence_penalty = 0,
        -- temperature = 0.5,
        -- top_p = 0.9,
      },
    },
    textgenui = {
      api_host = jst_get_secret(vim.g.huggingface_url_env, vim.g.huggingface_url_file) or '',
      api_key = jst_get_secret(vim.g.huggingface_token_env, vim.g.huggingface_token_file) or '',
      api_params = {
        model = jst_get_secret(vim.g.huggingface_code_model_env, vim.g.huggingface_code_model_file) or vim.g.huggingface_code_model or '',
        -- temperature = 0.8,
        -- top_p = 0.9,
      },
      api_chat_params = {
        model = jst_get_secret(vim.g.huggingface_chat_model_env, vim.g.huggingface_chat_model_file) or vim.g.huggingface_chat_model or '',
        -- frequency_penalty = 0,
        -- presence_penalty = 0,
        -- temperature = 0.5,
        -- top_p = 0.9,
      },
    },
  },
  edgy = true, -- enable this. See lua/plugins/edgy.lua for options
  single_window = false, -- set this to true if you want only one OGPT window to appear at a time
}
-- For debugging: OGPT_opts=opts
return {
  {
    "huynle/ogpt.nvim",
    enabled = opts.default_provider ~= '',
    event = "VeryLazy",
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
