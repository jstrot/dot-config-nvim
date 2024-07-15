-- https://github.com/tzachar/cmp-ai
return {
  {
    'tzachar/cmp-ai',
    enabled = false,  -- TODO
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      provider = 'Ollama',
      provider_options = {
        model = 'phi3:3.8b',
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
    },
  }
}

-- vim: sw=2 et
