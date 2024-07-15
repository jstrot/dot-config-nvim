-- https://github.com/huynle/ogpt.nvim
return {
  {
    "huynle/ogpt.nvim",
    event = "VeryLazy",
    opts = {
      default_provider = "ollama",
      providers = {
        ollama = {
          api_host = os.getenv("OLLAMA_API_HOST") or "http://ollama.jsoft.lan:11434",
          api_key = os.getenv("OLLAMA_API_KEY") or "",
          -- default model
          -- model = "mistral:7b",
          model = "phi3:3.8b",
          -- model definitions
          models = {
            -- alias to actual model name, helpful to define same model name across multiple providers
            coder = "deepseek-coder:1.3b",
            -- nested alias
            cool_coder = "coder",
            -- general_model = "mistral:7b",
            general_model = "phi3:3.8b",
            custom_coder = {
              name = "deepseek-coder:1.3b",
              modify_url = function(url)
                -- completely modify the URL of a model, if necessary. This function is called
                -- right before making the REST request
                return url
              end,
              -- custom conform function. Each provider have a dedicated conform function where all
              -- of OGPT chat info is passed into the conform function to be massaged to the
              -- correct format that the provider is expecting. This function, if provided will
              -- override the provider default conform function
              -- conform_fn = function(ogpt_params)
              --   return provider_specific_params
              -- end,
            },
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}

-- vim: sw=2 et
