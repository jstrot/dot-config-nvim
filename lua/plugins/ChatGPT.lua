-- https://github.com/jackMort/ChatGPT.nvim
local uv = vim.uv or vim.loop
return {
  {
    'jackMort/ChatGPT.nvim',
    enabled = uv.fs_stat(vim.env.HOME .. '/.OPENAI_API_KEY') ~= nil,
    event = 'VeryLazy',
    config = function()
      require('chatgpt').setup({
        api_key_cmd = 'cat ' .. vim.env.HOME .. '/.OPENAI_API_KEY || echo dummy',
        api_host_cmd = 'cat ' .. vim.env.HOME .. '/.OPENAI_API_HOST || echo dummy',
        openai_params = {
          model = 'codellama:13b',
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        -- openai_params = {
        --   model = 'mistral',
        --   frequency_penalty = 0,
        --   presence_penalty = 0,
        --   max_tokens = 4095,
        --   temperature = 0.2,
        --   top_p = 0.1,
        --   n = 1,
        -- }
        openai_edit_params = {
          model = 'codellama:13b',
          frequency_penalty = 0,
          presence_penalty = 0,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      })
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
      'nvim-telescope/telescope.nvim'
    }
  }
}

-- vim: sw=2 et
