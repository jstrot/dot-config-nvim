-- https://github.com/huggingface/llm.nvim
require('config.ai')
require('functions.secret')

local opts = {
  -- backend = TBD,
  accept_keymap = "<Tab>",
  dismiss_keymap = "<S-Tab>",
  context_window = 1024, -- max number of tokens for the context window
  enable_suggestions_on_startup = true,
  enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
  -- disable_url_path_completion = false, -- cf Backend
  -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
  request_body = {
    -- Modelfile options for the model you use
    options = {
      temperature = 0.2,
      top_p = 0.95,
    },
  },
}

if not opts.backend then
  local api_token = jst_get_secret('LLM_NVIM_HF_API_TOKEN', nil) or jst_get_secret(vim.g.huggingface_token_env, vim.g.huggingface_token_file)
  if api_token then
    -- https://github.com/huggingface/llm.nvim?tab=readme-ov-file#backend--huggingface
    opts = vim.tbl_deep_extend('force', opts, {
      backend = 'huggingface',
      api_token = api_token,
      model = jst_get_secret('LLM_NVIM_MODEL', nil) or jst_get_secret(vim.g.huggingface_code_model_env, nil) or vim.g.huggingface_code_model,
    })
  end
end

if not opts.backend then
  local url = jst_get_secret(vim.g.ollama_url_env, vim.g.ollama_url_file)
  if url then
    opts = vim.tbl_deep_extend('force', opts, {
      backend = 'ollama',
      url = url, -- llm-ls uses "/api/generate"
      api_token = jst_get_secret(vim.g.ollama_token_env, vim.g.ollama_token_file),
      model = jst_get_secret('LLM_NVIM_MODEL', nil) or jst_get_secret(vim.g.ollama_code_model_env, vim.g.ollama_code_model_file) or vim.g.ollama_code_model,
    })
  end
end

if opts.backend and not vim.g.auto_suggest_completion_plugin then
  vim.g.auto_suggest_completion_plugin = 'llm'
end

-- For debugging: LLM_opts=opts
return {
  {
    'huggingface/llm.nvim',
    enabled = opts.backend ~= nil,
    cond = vim.g.auto_suggest_completion_plugin == 'llm',
    -- event = 'VeryLazy' | 'InsertEnter', -- Does not load on command-line files until `:e`
    event = { "BufReadPre", "BufNewFile" },
    opts = opts,
    keys = {
      { '<leader>tc', '<cmd>LLMToggleAutoSuggest<CR>', desc = '[T]oggle AI auto-[C]ompletion suggestions' },
    },
  }
}

-- vim: sw=2 et
