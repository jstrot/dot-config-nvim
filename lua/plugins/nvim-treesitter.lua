-- https://github.com/nvim-treesitter/nvim-treesitter
-- INSTRUCTIONS:
--   - Install new parsers with `:TSInstall <parser>`
return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all". See `TSInstallInfo` for available parsers.
        ensure_installed = {
          -- 'bash',
          'c', 'cpp',
          -- 'cmake',
          -- 'css', 'scss',
          'doxygen',
          -- 'html',
          -- 'java',
          -- 'javascript', 'typescript',
          'json', 'json5',
          'lua',
          -- 'make',
          'markdown',
          'python',
          -- 'regex',
          'toml', 'yaml',
          'vim',
          'vimdoc',
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (or "all")
        ignore_install = {
          -- "c",
        },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = {
            -- "c",
          },
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
            -- Disable treesitter in help files. (EXTREME speedup => From 0 fps to 165 fps)
            if vim.bo.filetype == 'help' then
                return true
            end
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
            return false
          end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
      })

      -- Enable for auto-update:
      if false then
        local ts_update = require("nvim-treesitter.install").update({ with_sync = true })()
        ts_update()
      end

      vim.opt.foldenable = false
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
  }
}

-- vim: sw=2 et
