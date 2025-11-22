-- https://github.com/jackMort/ChatGPT.nvim
require('jst.ai.config')

local api_host = AI_openai_url()
local api_key = AI_openai_api_key()
return {
  {
    'jackMort/ChatGPT.nvim',
    enabled = api_key ~= nil,
    cmd = {
      'ChatGPT',
      'ChatGPTActAs',
      'ChatGPTCompleteCode',
      'ChatGPTEditWithInstructions',
      'ChatGPTRun',
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
      'nvim-telescope/telescope.nvim'
    },
    opts = {
      openai_params = {
        model = AI_openai_chat_model(),
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
