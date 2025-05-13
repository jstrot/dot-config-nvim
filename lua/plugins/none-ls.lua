-- https://github.com/nvimtools/none-ls.nvim
-- (drop-in successor to null-ls)

-- Use a custom clang-format. Also see nvim-lspconfig.lua
local use_custom_clang_format = (vim.g.clang_format_host_prog ~= nil)

return {
  {
    "nvimtools/none-ls.nvim",
    event = 'VeryLazy',
    branch = "main",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- https://github.com/nvimtools/none-ls-extras.nvim
      "nvimtools/none-ls-extras.nvim"
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        -- debug = true, -- Enable and check logs with `:NullLsLog`

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
          null_ls.builtins.formatting.stylua, -- Lua
          -- null_ls.builtins.formatting.autopep8, -- Python: use ruff instead
          -- null_ls.builtins.formatting.autoflake, -- Python: use ruff instead
          require("none-ls.formatting.ruff"), -- Python
          null_ls.builtins.formatting.black, -- Python

          use_custom_clang_format and null_ls.builtins.formatting.clang_format.with({ -- C/C++, C#, Java, Cuda, Proto
            command = vim.g.clang_format_host_prog or 'clang-format',
            extra_args = {
              "--fallback-style=GNU", -- Only use as default if no .clang-format file is found
            }
          }) or nil,

          null_ls.builtins.formatting.buildifier, -- Bazel

          -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/completion
          null_ls.builtins.completion.spell,
          null_ls.builtins.completion.tags,

          -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
          -- https://github.com/nvimtools/none-ls-extras.nvim/tree/main/lua/none-ls/diagnostics

          null_ls.builtins.diagnostics.buildifier, -- Bazel

          -- https://github.com/nvimtools/none-ls.nvim/blob/main/lua/null-ls/builtins/diagnostics/markdownlint.lua
          -- null_ls.builtins.diagnostics.markdownlint, -- Disabled because it keeps running when not available
          -- https://github.com/nvimtools/none-ls.nvim/blob/main/lua/null-ls/builtins/diagnostics/markdownlint_cli2.lua
          -- null_ls.builtins.diagnostics.markdownlint_cli2,

          --[[ Python ]]
          -- See nvim-lspconfig.lua -- null_ls.builtins.formatting.autopep8, -- use ruff instead
          -- See nvim-lspconfig.lua -- null_ls.builtins.formatting.autoflake, -- use ruff instead
          -- See nvim-lspconfig.lua require("none-ls.formatting.ruff"), -- Python
          -- See nvim-lspconfig.lua null_ls.builtins.formatting.black, -- Python
          -- See nvim-lspconfig.lua -- null_ls.builtins.diagnostics.flake8, -> use ruff instead
          -- See nvim-lspconfig.lua require("none-ls.diagnostics.ruff"),

        },
      })
    end
  },
  {
    "nvimtools/none-ls-extras.nvim",
  }
}

-- vim: sw=2 et
