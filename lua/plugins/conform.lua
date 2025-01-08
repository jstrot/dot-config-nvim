-- https://github.com/stevearc/conform.nvim
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = {
      "ConformInfo",
      "FormatOnSaveDisable",
      "FormatOnSaveEnable",
      "FormatOnSaveToggle",
    },
    keys = {
      {
        "<leader>f<cr>",
        function()
          require("conform").format({ async = false }, function(err)
            if not err then
              -- Leave visual mode after range format
              local mode = vim.api.nvim_get_mode().mode
              if vim.startswith(string.lower(mode), "v") then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
              end
            end
          end)
        end,
        mode = { "n", "v" },
        desc = '[F]ormat using "conform"',
      },
    },
    opts = {
      notify_on_error = false,

      -- https://github.com/stevearc/conform.nvim#formatters
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        python = {
          "autopep8",
          "ruff_format",
          "black",
          "blue",
          "pyink",
          "yapf",
          -- "ruff_fix",
          "ruff_organize_imports",
          "isort",
          "usort",
          "reorder-python-imports",
          stop_after_first = true,
        },
        -- You can use the `stop_after_first` option to stop after the first successful formatter.
        javascript = {
          "prettierd",
          "prettier",
          stop_after_first = true,
        },
        php = { "php" },
        xml = {
          "xmlformatter", -- xmlformatter is an Open Source Python package, which provides formatting of XML documents.
          "xmllint", -- Despite the name, xmllint can be used to format XML files as well as lint them.
          "xmlstarlet", -- XMLStarlet is a command-line XML toolkit that can be used to format XML files.
          stop_after_first = true,
        },
      },
      formatters = {
        php = {
          command = "php-cs-fixer",
          args = {
            "fix",
            -- Formatting ruleset preset: https://github.com/PHP-CS-Fixer/PHP-CS-Fixer/blob/master/doc/ruleSets/index.rst
            "--rules=@PSR12",
            -- "--config=/your/path/to/config/file/[filename].php",
            -- "--allow-risky=yes", -- if you have risky stuff in config, if not you dont need it.
            "$FILENAME",
          },
          stdin = false,
        },
      },
      format_on_save = function(bufnr)
        -- Disable format on save for for languages that don't have a well
        -- standardized coding style.
        -- You can enable or disable per file type or use the default.
        -- You can also set custom options for each file type, or use the default options with true.
        local default_format_on_save = false
        local format_on_save_fts = {
          c = false,
          cpp = false,
          php = false,
          lua = true,
        }
        local format_on_save_default_opts = {
          timeout_ms = 500,
          lsp_fallback = "fallback",
        }
        local format_on_save = nil
        if vim.b[bufnr].disable_format_on_save ~= nil then
          format_on_save = vim.b[bufnr].disable_format_on_save
        elseif vim.g.disable_format_on_save ~= nil then
          format_on_save = vim.g.disable_format_on_save
        end
        if format_on_save == nil then
          format_on_save = format_on_save_fts[vim.bo[bufnr].filetype]
        elseif format_on_save then
          format_on_save = format_on_save_fts[vim.bo[bufnr].filetype]
          if format_on_save == false then
            -- disable_format_on_save variable overrides the file type default
            format_on_save = true
          end
        end
        if format_on_save == nil then
          format_on_save = default_format_on_save
        end
        if format_on_save == true then
          format_on_save = format_on_save_default_opts
        end
        return format_on_save
      end,
    },
    config = function(_, opts)
      require("conform").setup(opts)

      vim.api.nvim_create_user_command("FormatOnSaveDisable", function(args)
        if args.bang then
          -- FormatOnSaveDisable! will disable formatting just for this buffer
          vim.b.disable_format_on_save = true
        else
          vim.g.disable_format_on_save = true
        end
      end, {
        desc = "Disable format-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatOnSaveEnable", function(args)
        if args.bang then
          -- FormatOnSaveEnable! will disable formatting just for this buffer
          vim.b.disable_format_on_save = false
        else
          vim.g.disable_format_on_save = false
        end
      end, {
        desc = "Enable format-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatOnSaveToggle", function(args)
        if args.bang then
          -- FormatOnSaveToggle! will disable formatting just for this buffer
          if vim.b.disable_format_on_save == nil then
            vim.b.disable_format_on_save = not vim.g.disable_format_on_save
          else
            vim.b.disable_format_on_save = not vim.b.disable_format_on_save
          end
        else
          vim.g.disable_format_on_save = not vim.g.disable_format_on_save
        end
      end, {
        desc = "Toggle format-on-save",
        bang = true,
      })
      vim.keymap.set(
        "n",
        "<leader>tf",
        "<cmd>FormatOnSaveToggle<CR>",
        { desc = '[T]oggle [F]ormat-on-save using "conform"' }
      )
    end,
  },
}

-- vim: sw=2 et
