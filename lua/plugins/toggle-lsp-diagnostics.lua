-- https://github.com/qualIP/toggle-lsp-diagnostics.nvim
return {
  {
    "qualIP/toggle-lsp-diagnostics.nvim",
    name = "qualip-toggle-lsp-diagnostics",
    config = function()
      require('toggle_lsp_diagnostics').init()
      vim.keymap.set('n', '<leader>tlu',     '<Plug>(toggle-lsp-diag-underline)',        { desc = '[T]oggle [L]SP diagnostics [U]nderline' })
      vim.keymap.set('n', '<leader>tsl',     '<Plug>(toggle-lsp-diag-signs)',            { desc = '[T]oggle [S]ign column [L]SP diagnostics' })
      vim.keymap.set('n', '<leader>tls',     '<Plug>(toggle-lsp-diag-signs)',            { desc = '[T]oggle [L]SP diagnostics [S]igns' })
      vim.keymap.set('n', '<leader>tlv',     '<Plug>(toggle-lsp-diag-vtext)',            { desc = '[T]oggle [L]SP diagnostics [V]irtual text' })
      vim.keymap.set('n', '<leader>tlp',     '<Plug>(toggle-lsp-diag-update_in_insert)', { desc = '[T]oggle [L]SP diagnostics information u[P]date while in insert mode' })
      vim.keymap.set('n', '<leader>tld<cr>', '<Plug>(toggle-lsp-diag)',                  { desc = '[T]oggle all [L]SP [D]iagnostics' })
      vim.keymap.set('n', '<leader>tldd',    '<Plug>(toggle-lsp-diag-default)',          { desc = '[T]oggle all [L]SP [D]iagnostics back to [D]efaults (on, except overrides passed on init)' })
      vim.keymap.set('n', '<leader>tldo',    '<Plug>(toggle-lsp-diag-on)',               { desc = '[T]oggle all [L]SP [D]iagnostics [O]n' })
      vim.keymap.set('n', '<leader>tldf',    '<Plug>(toggle-lsp-diag-off)',              { desc = '[T]oggle all [L]SP [D]iagnostics o[F]f' })
    end,
  }
}

-- vim: sw=2 et
