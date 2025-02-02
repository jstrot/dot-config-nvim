-- https://github.com/jackMort/ChatGPT.nvim
require('config.ai')
require('functions.secret')
local api_host = jst_get_secret(vim.g.openai_url_env, vim.g.openai_url_file)
local api_key = jst_get_secret(vim.g.openai_token_env, vim.g.openai_token_file)
return {
  {
    'jackMort/ChatGPT.nvim',
    enabled = api_key ~= nil,
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
      'nvim-telescope/telescope.nvim'
    },
    opts = {
      openai_params = {
        model = jst_get_secret(vim.g.openai_chat_model_env, vim.g.openai_chat_model_file) or vim.g.openai_chat_model,
        -- frequency_penalty = 0,
        -- presence_penalty = 0,
        -- max_tokens = 300,
        -- temperature = 0,
        -- top_p = 1,
        -- n = 1,
      },
    },
    init = function()
      -- For simplicity and speed, use the default environment variables to set it up
      if api_host then vim.uv.os_setenv('OPENAI_API_HOST', api_host) end
      vim.uv.os_setenv('OPENAI_API_KEY', api_key)
    end
  }
}

-- vim: sw=2 et
