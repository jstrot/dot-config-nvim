-- INSTRUCTIONS:
--   - Install new parsers with `:TSInstall <parser>`
local jst_ts = require('jst.treesitter.config')
local jst_csv = require('jst.csv')

-- jst.ts_enabled = false

-- You can rely on `auto_install_new_parsers` to install missing parsers as new
-- filetypes are opened. Or you can add to the `ensure_install` list to install
-- them automatically on startup.
local auto_install_new_parsers = true
local ensure_install = {
  -- 'bash',
  -- 'c', 'cpp',
  -- 'cmake',
  -- 'css', 'scss',
  -- 'doxygen',
  -- 'html',
  -- 'java',
  -- 'javascript', 'typescript',
  -- 'json', 'json5', 'jsonc',
  'lua',
  -- 'make',
  'markdown',
  'markdown_inline',
  -- 'python',
  -- 'regex',
  -- 'toml', 'yaml',
  -- 'vim',
  'vimdoc',
}

local feat_opts = {
  -- Enable highlighting, indentation, and folding per filetype
  highlight = {
    enable = true, -- default
    -- 'filetype' = true/false,
  },
  indent = {
    enable = true, -- default
    -- 'filetype' = true/false,
  },
  folds = {
    enable = true, -- default
    -- 'filetype' = true/false,
  },
}

local ts_opts = {
  keys = {
    { '<leader>tt<cr>', '<cmd>TSToggle highlight<CR>',    desc = '[T]oggle [T]reesitter highlight' },
    { '<leader>ttb',    '<cmd>TSBufToggle highlight<CR>', desc = '[T]oggle [T]reesitter highlight in [B]uffer' },
    { '<leader>tti',    '<cmd>TSBufToggle indent<CR>',    desc = '[T]oggle [T]reesitter [i]ndent in buffer' },
  },
}

if jst_csv.rainbow_csv_enabled then
  -- Disable treesitter in CSV files if you're using a plugin such as rainbow_csv
  for _, ft in ipairs(jst_csv.csv_filetypes) do
    feat_opts.highlight[ft] = false
  end
end

return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = jst_ts.ts_enabled,
    -- main:   Neovim 0.12.0 or later (nightly)
    -- master: Neovim 0.10 or 0.11 (Neovim 0.12 is not supported)
    branch = vim.fn.has('nvim-0.12') and 'main' or 'master',
    lazy = false, -- "This plugin does not support lazy-loading."
    build = function()
      if vim.fn.executable('tree-sitter') == 0 then
        vim.notify('tree-sitter CLI not found. Install with `:MasonInstall tree-sitter-cli`')
      else
        vim.cmd [[ TS update ]]
      end
    end,
    opts = ts_opts,
    config = function(_, opts)
      local ts = require('nvim-treesitter')
      ts.setup(opts)
      if false then
        -- Without ts-install, install default parsers on startup here instead
        ts.install(ensure_install) -- async
      end

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
          if not jst_ts.have(ft) then
            return
          end

          local function enabled(feat, query)
            local f = feat_opts[feat] or {} ---@type lazyvim.TSFeat
            return f.enable ~= false
            and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
            and jst_ts.have(ft, query)
          end

          if enabled("highlight", "highlights") then
            vim.treesitter.start()
          end
          if enabled("indent", "indents") then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
          if enabled("folds", "folds") then
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'
          end

        end,
      })

    end,
    init = function()
      vim.g.loaded_nvim_treesitter = 1 -- For ts-install?
    end,
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  },

  -- https://github.com/lewis6991/ts-install.nvim
  {
    'lewis6991/ts-install.nvim',
    enabled = jst_ts.ts_enabled,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      ensure_install = ensure_install,
      auto_install = auto_install_new_parsers,
    }
  },

  -- https://github.com/geigerzaehler/tree-sitter-jinja2
  {
    "geigerzaehler/tree-sitter-jinja2",
    dependencies = { 'neovim/nvim-lspconfig' },
  },

}

-- vim: sw=2 et
