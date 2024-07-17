-- https://github.com/nvimtools/none-ls.nvim
-- (drop-in successor to null-ls)
return {
  {
    "nvimtools/none-ls.nvim",
    -- debug = true,
    branch = "main",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- https://github.com/nvimtools/none-ls-extras.nvim
      "nvimtools/none-ls-extras.nvim"
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = true,

        on_init = function(new_client, _)
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
          if new_client.name == 'ccls' then
            -- Why? 'ccls' only supports 'utf-32'
            new_client.offset_encoding = 'utf-32'
          else
            -- Why? 'GitHub Copilot' only supports 'utf-16' ?!
            new_client.offset_encoding = 'utf-16'
          end
        end,

        sources = {
          -- References:
          --   bultins: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
          --   none-ls extras: https://github.com/nvimtools/none-ls-extras.nvim/tree/main/lua/none-ls
          -- Deprecations: https://github.com/nvimtools/none-ls.nvim/discussions/81

          -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
          -- https://github.com/nvimtools/none-ls-extras.nvim/tree/main/lua/none-ls/formatting
          null_ls.builtins.formatting.stylua,
          -- null_ls.builtins.formatting.autopep8, -> ruff
          -- null_ls.builtins.formatting.autoflake, -> ruff
          require("none-ls.formatting.ruff"),
          null_ls.builtins.formatting.black,

          -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/completion
          -- https://github.com/nvimtools/none-ls-extras.nvim/tree/main/lua/none-ls/completion
          null_ls.builtins.completion.spell,
          null_ls.builtins.completion.tags,

          -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
          -- https://github.com/nvimtools/none-ls-extras.nvim/tree/main/lua/none-ls/diagnostics
          -- null_ls.builtins.diagnostics.flake8, -> ruff
          require("none-ls.diagnostics.ruff"),
        },
      })
    end
  },
  {
    "nvimtools/none-ls-extras.nvim",
  }
}

-- vim: sw=2 et
