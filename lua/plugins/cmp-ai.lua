-- https://github.com/tzachar/cmp-ai
-- WARN: Not tested in a while given nvim-cmp is not in use
require('jst.ai.config')

local opts = {
  -- provider = TBD,
  provider = nil,
  provider_options = {
    auto_unload = false,
  },
  max_lines = 1000,
  notify = true,
  notify_callback = function(msg)
    vim.notify(msg)
  end,
  run_on_every_keystroke = true,
  ignored_file_types = {
    -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true
  },
}

if
  opts.provider
  or (
    vim.g.auto_suggest_completion_plugin == 'cmp-ai'
    or vim.g.auto_suggest_completion_plugin == nil
  )
then

  if not opts.provider then
    if AI_is_huggingface_enabled() and AI_huggingface_code_model() then
      vim.fn.setenv('HF_API_KEY', AI_huggingface_api_key()) -- only by environment!?
      opts = vim.tbl_deep_extend('force', opts, {
        provider = 'HF',
        provider_options = {
          model = AI_huggingface_code_model(),
        },
      })
    end
  end

  if not opts.provider then
    if AI_is_ollama_enabled() and AI_ollama_code_model() then
      opts = vim.tbl_deep_extend('force', opts, {
        provider = 'Ollama',
        base_url = AI_ollama_url() .. '/api/generate',
        -- opts.api_token = AI_ollama_api_key(),
        provider_options = {
          model = AI_ollama_code_model(),
        },
      })
    end
  end

  if not opts.provider then
    if AI_is_openai_enabled() and AI_openai_code_model() then
      vim.fn.setenv('OPEN_API_KEY', AI_openai_api_key()) -- only by environment!?
      opts = vim.tbl_deep_extend('force', opts, {
        provider = 'OpenAI',
        base_url = AI_openai_url() .. '/api/generate',
        provider_options = {
          model = AI_openai_code_model(),
        },
      })
    end
  end

  local model = opts.provider_options.model
  if model then
    if string.find(model, 'codegemma') then
      -- If the model supports the suffix parameter:
      --   {{- if .Suffix }}<|fim_prefix|>{{ .Prompt }}<|fim_suffix|>{{ .Suffix }}<|fim_middle|>
      --   {{- else }}{{ .Prompt }}
      --   {{- end }}
      opts = vim.tbl_deep_extend('keep', opts, {
        prompt = function(lines_before, lines_after)
          return lines_before
        end,
        suffix = function(lines_after)
          return lines_after
        end,
      })
    elseif string.find(model, 'qwen2.5-coder') then
      -- qwen2.5-coder used <|fim_prefix|>, <|fim_middle|> and <|fim_suffix|> (as well as some other special tokens for project context) as the delimiter for fill-in-middle code completion
      opts = vim.tbl_deep_extend('keep', opts, {
        prompt = function(lines_before, lines_after)
          -- You may include filetype and/or other project-wise context in this string as well.
          -- Consult model documentation in case there are special tokens for this.
          return "<|fim_prefix|>" .. lines_before .. "<|fim_suffix|>" .. lines_after .. "<|fim_middle|>"
        end,
      })
    end
  end

  if
    vim.g.cmp_plugin == 'nvim-cmp'
    and opts.backend
    and vim.g.auto_suggest_completion_plugin == nil
  then
    vim.g.auto_suggest_completion_plugin = 'cmp-ai'
  end
end

return {
  {
    'tzachar/cmp-ai',
    enabled = vim.g.cmp_plugin == 'nvim-cmp' and opts.provider ~= nil,
    cond = vim.g.auto_suggest_completion_plugin == 'cmp-ai',
    event = 'InsertEnter',
    opts = opts,
    config = function(_, opts)
      local cmp_ai = require('cmp_ai.config')

      cmp_ai:setup(opts)

      require('cmp').setup {
        sources = {
          { name = 'cmp_ai' },
        },
      }
    end,
    dependencies = {
      'hrsh7th/nvim-cmp',
      'nvim-lua/plenary.nvim',
    },
  },
}

-- vim: sw=2 et
