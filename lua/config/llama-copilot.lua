require('llama-copilot').setup({
  host = "ollama.jsoft.lan",
  port = "11434",
  -- model = "codellama:7b-code",
  model = "phi3:3.8b",
  -- max_completion_size = 15,
  max_completion_size = -1, -- limitless
  debug = false,
})

-- vim: sw=2 et
