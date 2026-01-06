-- https://github.com/huggingface/llm.nvim
require('jst.ai.config')
local jst = require('jst')

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

if
  opts.backend
  or (
    vim.g.auto_suggest_completion_plugin == 'llm'
    or vim.g.auto_suggest_completion_plugin == nil
  )
then

  if not opts.backend then
    if AI_is_huggingface_enabled() and (jst.fn.get_secret('LLM_NVIM_MODEL', nil) or AI_huggingface_code_model()) then
      -- https://github.com/huggingface/llm.nvim?tab=readme-ov-file#backend--huggingface
      opts = vim.tbl_deep_extend('force', opts, {
        backend = 'huggingface',
        url = AI_huggingface_url() or nil,
        api_token = AI_huggingface_api_key(),
        model = jst.fn.get_secret('LLM_NVIM_MODEL', nil) or AI_huggingface_code_model(),
      })
    end
  end

  if not opts.backend then
    if AI_is_ollama_enabled() and (jst.fn.get_secret('LLM_NVIM_MODEL', nil) or AI_ollama_code_model()) then
      opts = vim.tbl_deep_extend('force', opts, {
        backend = 'ollama',
        url = AI_ollama_url(), -- llm-ls uses "/api/generate"
        api_token = AI_ollama_api_key(),
        model = jst.fn.get_secret('LLM_NVIM_MODEL', nil) or AI_ollama_code_model(),
      })
    end
  end

  if not opts.backend then
    if AI_is_openai_enabled() and (jst.fn.get_secret('LLM_NVIM_MODEL', nil) or AI_openai_code_model()) then
      opts = vim.tbl_deep_extend('force', opts, {
        backend = 'openai',
        url = AI_openai_nover_url(), -- llm-ls uses "/v1/completions"
        api_token = AI_openai_api_key(),
        model = jst.fn.get_secret('LLM_NVIM_MODEL', nil) or AI_openai_code_model(),
      })
    end
  end

  local model = opts.model
  if model then
    if model:find('starcoder') then
      opts = vim.tbl_deep_extend('keep', opts, {
        tokens_to_clear = { "<|endoftext|>" },
        fim = {
          enabled = true,
          prefix = "<fim_prefix>",
          middle = "<fim_middle>",
          suffix = "<fim_suffix>",
        },
        context_window = 8192,
        -- tokenizer = {
        --   repository = "bigcode/starcoder",
        -- }
      })
    elseif model:find('codellama') then
      opts = vim.tbl_deep_extend('keep', opts, {
        tokens_to_clear = { "<EOT>" },
        fim = {
          enabled = true,
          prefix = "<PRE> ",
          middle = " <MID>",
          suffix = " <SUF>",
        },
        context_window = 4096,
        -- tokenizer = {
        --   repository = "codellama/CodeLlama",
        -- }
      })
    end
  end

  if
    opts.backend
    and vim.g.auto_suggest_completion_plugin == nil
  then
    vim.g.auto_suggest_completion_plugin = 'llm'
  end

end

return {
  {
    'huggingface/llm.nvim',
    enabled = opts.backend ~= nil,
    cond = vim.g.auto_suggest_completion_plugin == 'llm',
    event = 'InsertEnter',
    opts = opts,
    keys = {
      { '<leader>tc', '<cmd>LLMToggleAutoSuggest<CR>', desc = '[T]oggle AI auto-[C]ompletion suggestions' },
    },
  }
}

-- vim: sw=2 et
