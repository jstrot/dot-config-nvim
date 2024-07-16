-- https://github.com/Faywyn/llama-copilot.nvim
return {
  {
    "Faywyn/llama-copilot.nvim",
    enabled = false,   -- TODO fill host below!
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      host = "TODO",
      port = "11434",
      model = "codellama:7b-code",
      -- model = "phi3:3.8b",
      -- max_completion_size = 15,
      max_completion_size = -1, -- limitless
      debug = false,
    }
  }
}

-- vim: sw=2 et
