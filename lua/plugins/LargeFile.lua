-- https://github.com/vim-scripts/LargeFile
return {
  {
    "vim-scripts/LargeFile",

    init = function()
      vim.g.LargeFile = 10 -- The default is 20 (megs)
    end,

    config = function()

      -- The LargeFile plugin sets `vim.b.LargeFile_mode=1` when it detects a large file.
      -- Dynamic checks (like in nvim-treesitter plugin) can check this variable.
      -- When not possible, you may enter extra commands in the callback below.

      vim.api.nvim_create_autocmd('BufReadPre', {
        callback = function(event)
          local max_filesize = (vim.g.LargeFile or 20) * 1024 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, event.file)
          if ok and stats and stats.size > max_filesize then
            -- This is a large file

            vim.b.copilot_enabled = false

          end
        end,
      })

      function ToggleLargeFile()
        if vim.b.LargeFile_mode == 1 then
          vim.cmd [[ Unlarge ]]
        else
          vim.cmd [[ Large! % ]]
        end
      end

      vim.keymap.set('n', '<leader>tL', ToggleLargeFile, { desc = '[T]oggle [L]arge file handling' })

    end,
  },
}

-- vim: sw=2 et
