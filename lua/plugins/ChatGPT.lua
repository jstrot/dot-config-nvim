-- https://github.com/jackMort/ChatGPT.nvim
local home = vim.fn.expand("$HOME")
local f = io.open(home .. "/.OPENAI_API_KEY")
if f then
io.close(f)
return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        -- api_key_cmd = "echo http://172.16.66.4:11434",
        api_key_cmd = "echo http://ollama.jsoft.lan:11434",
        -- api_key_cmd = "cat " .. home .. "/.OPENAI_API_KEY",
        api_host_cmd = "echo ''",
        -- api_host_cmd = "cat " .. home .. "/.OPENAI_API_HOST",
        openai_params = {
          model = "codellama:13b",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        -- openai_params = {
        --   model = "mistral",
        --   frequency_penalty = 0,
        --   presence_penalty = 0,
        --   max_tokens = 4095,
        --   temperature = 0.2,
        --   top_p = 0.1,
        --   n = 1,
        -- }
        openai_edit_params = {
          model = "codellama:13b",
          frequency_penalty = 0,
          presence_penalty = 0,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}
else
return {}
end
-- vim: sw=2 et
