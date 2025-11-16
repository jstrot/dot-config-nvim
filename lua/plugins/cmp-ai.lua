-- https://github.com/tzachar/cmp-ai
require('jst.ai.config')

local enabled = false -- TBD below
local def_opts = {
  -- provider = TBD,
  provider = nil,
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

local huggingface_opts = nil
local api_token = AI_huggingface_api_key()
if api_token then
  enabled = true
  vim.us.os_setenv('HF_API_KEY', api_token) -- only by environment!?
  huggingface_opts = vim.tbl_deep_extend('force', def_opts, {
    provider = 'HF',
    model = AI_huggingface_code_model(),
  })
end

local ollama_opts = nil
local url = AI_ollama_url()
if url then
  enabled = true
  local model = AI_ollama_code_model()
  ollama_opts = vim.tbl_deep_extend('force', def_opts, {
    provider = 'Ollama',
    base_url = url .. '/api/generate',
    -- opts.api_token = AI_ollama_api_key(),
    provider_options = {
      model = model,
      auto_unload = false,
    },
  })
  if string.find(model, 'codegemma') then
    -- If the model supports the suffix parameter:
    --   {{- if .Suffix }}<|fim_prefix|>{{ .Prompt }}<|fim_suffix|>{{ .Suffix }}<|fim_middle|>
    --   {{- else }}{{ .Prompt }}
    --   {{- end }}
    ollama_opts = vim.tbl_deep_extend('keep', ollama_opts, {
      prompt = function(lines_before, lines_after)
        return lines_before
      end,
      suffix = function(lines_after)
        return lines_after
      end,
    })
  elseif string.find(model, 'qwen2.5-coder') then
    -- qwen2.5-coder used <|fim_prefix|>, <|fim_middle|> and <|fim_suffix|> (as well as some other special tokens for project context) as the delimiter for fill-in-middle code completion
    ollama_opts = vim.tbl_deep_extend('keep', ollama_opts, {
      prompt = function(lines_before, lines_after)
        -- You may include filetype and/or other project-wise context in this string as well.
        -- Consult model documentation in case there are special tokens for this.
        return "<|fim_prefix|>" .. lines_before .. "<|fim_suffix|>" .. lines_after .. "<|fim_middle|>"
      end,
    })
  end
end

return {
  {
    'tzachar/cmp-ai',
    enabled = vim.g.cmp_plugin == 'nvim-cmp' and enabled,
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = opts,
    config = function(_, opts)
      require('cmp_ai').setup(opts)
      local cmp_ai = require('cmp_ai.config')

      if huggingface_opts then cmp_ai:setup(huggingface_opts) end
      if ollama_opts then cmp_ai:setup(ollama_opts) end

      require('cmp').setup {
        sources = {
          { name = 'cmp_ai' },
        },
      }
    end
  },
}

-- vim: sw=2 et
