-- https://github.com/terrastruct/d2-vim
return {
  {
    'terrastruct/d2-vim',
    ft = {
      'd2',
    },
    cmd = {
      'D2Preview',          -- Render current buffer as ASCII in preview window
      'D2PreviewToggle',    -- Toggle ASCII preview window on/off
      'D2PreviewUpdate',    -- Update existing preview window with current content
      'D2PreviewCopy',      -- Copy ASCII preview content to clipboard and yank register
      'D2PreviewSelection', -- Render selected text as ASCII (works in any file)
      'D2ReplaceSelection', -- Replace selected D2 code with ASCII render (works in any file)
      'D2AsciiToggle',      -- Toggle automatic ASCII rendering on save
      'D2Fmt',              -- Format current buffer
      'D2FmtToggle',        -- Toggle auto format on save
      'D2Validate',         -- Validate current buffer
      'D2ValidateToggle',   -- Toggle auto validate on save
      'D2Play',             -- Open current buffer in D2 playground
    },
    keys = {
      -- <Leader>d2 - Render selected text as ASCII (visual mode, any file)
      -- <Leader>d2 - Render entire buffer as ASCII (normal mode, D2 files only)
      -- <Leader>rd2 - Replace selected D2 code with ASCII render (visual mode, any file)
      -- <Leader>yd2 - Copy ASCII preview content to clipboard and yank register (normal mode, any file)
    },
    init = function()

      -- [[ Auto-formatting ]]
      -- Enable/disable auto format on save (default: 1)
      vim.g.d2_fmt_autosave = 1
      -- Customize the format command (default: "d2 fmt")
      vim.g.d2_fmt_command = "d2 fmt"
      -- Fail silently when formatting fails (default: 0)
      vim.g.d2_fmt_fail_silently = 0

      -- [[ Validation ]]
      -- Enable/disable auto validate on save (default: 0)
      vim.g.d2_validate_autosave = 0
      -- Customize the validate command (default: "d2 validate")
      vim.g.d2_validate_command = "d2 validate"
      -- Use quickfix or locationlist for errors (default: "quickfix")
      vim.g.d2_list_type = "quickfix"
      -- Fail silently when validation fails (default: 0)
      vim.g.d2_validate_fail_silently = 0

      -- [[ Playground ]]
      -- Customize the play command (default: "d2 play")
      vim.g.d2_play_command = "d2 play"
      -- Set the theme ID (default: 0)
      vim.g.d2_play_theme = 0
      -- Enable sketch mode (default: 0)
      vim.g.d2_play_sketch = 0

    end,
  }
}

-- vim: sw=2 et
