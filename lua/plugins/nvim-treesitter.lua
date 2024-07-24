-- https://github.com/nvim-treesitter/nvim-treesitter
-- INSTRUCTIONS:
--   - Install new parsers with `:TSInstall <parser>`
local uv = vim.uv or vim.loop
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- A list of parser names, or "all". See `TSInstallInfo` for available parsers.
      ensure_installed = {
        -- 'bash',
        -- 'c', 'cpp',
        -- 'cmake',
        -- 'css', 'scss',
        -- 'doxygen',
        -- 'html',
        -- 'java',
        -- 'javascript', 'typescript',
        -- 'json', 'json5',
        'lua',
        -- 'make',
        'markdown', 'markdown_inline',
        -- 'python',
        -- 'regex',
        -- 'toml', 'yaml',
        -- 'vim',
        -- FIXME: 'vimdoc' added by default to avoid the following error on first `:help` command:
        --     treesitter/query.lua:252: Query error at 2:4. Invalid node type "delimiter":
        --       (delimiter) @markup.heading.1
        --        ^
        'vimdoc',
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = true,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

        -- List of parsers to ignore installing (or "all")
      ignore_install = {
        -- "diff",
      },

      highlight = {
        enable = true,  -- false will disable the whole extension
        disable = function(lang, bufnr)
          -- Disable treesitter in help files. (EXTREME speedup => From 0 fps to 165 fps)
          if vim.bo.filetype == 'help' then
            return true
          end
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
          if ok and stats and stats.size > max_filesize then
            return true
          end
          return false
        end,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },

      indent = {
        enable = true,
        disable = {
          'ruby',
        },
      },
      rainbow = {
        enable = false,  -- Enable if you like this sort of thing!
        extended_mode = true,
        max_file_lines = nil,
      },
    },
    config = function(_, opts)
      -- Do not prefer git for installing parsers as it is not safe when already embedded in git.
      require('nvim-treesitter.install').prefer_git = false
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      vim.opt.foldenable = false
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    build = ':TSUpdate',
  }
}

-- vim: sw=2 et
