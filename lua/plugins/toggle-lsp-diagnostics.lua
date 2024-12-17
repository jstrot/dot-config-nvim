-- https://github.com/qualIP/toggle-lsp-diagnostics.nvim
return {
  {
    "qualIP/toggle-lsp-diagnostics.nvim",
    name = "qualip-toggle-lsp-diagnostics",
    keys = {
      { '<leader>tlu',     '<Plug>(toggle-lsp-diag-underline)',        mode = 'n', desc = '[T]oggle [L]SP diagnostics [U]nderline' },
      { '<leader>tsl',     '<Plug>(toggle-lsp-diag-signs)',            mode = 'n', desc = '[T]oggle [S]ign column [L]SP diagnostics' },
      { '<leader>tls',     '<Plug>(toggle-lsp-diag-signs)',            mode = 'n', desc = '[T]oggle [L]SP diagnostics [S]igns' },
      { '<leader>tlv',     '<Plug>(toggle-lsp-diag-vtext)',            mode = 'n', desc = '[T]oggle [L]SP diagnostics [V]irtual text' },
      { '<leader>tlp',     '<Plug>(toggle-lsp-diag-update_in_insert)', mode = 'n', desc = '[T]oggle [L]SP diagnostics information u[P]date while in insert mode' },
      { '<leader>tld<cr>', '<Plug>(toggle-lsp-diag)',                  mode = 'n', desc = '[T]oggle all [L]SP [D]iagnostics' },
      { '<leader>tldd',    '<Plug>(toggle-lsp-diag-default)',          mode = 'n', desc = '[T]oggle all [L]SP [D]iagnostics back to [D]efaults (on, except overrides passed on init)' },
      { '<leader>tldo',    '<Plug>(toggle-lsp-diag-on)',               mode = 'n', desc = '[T]oggle all [L]SP [D]iagnostics [O]n' },
      { '<leader>tldf',    '<Plug>(toggle-lsp-diag-off)',              mode = 'n', desc = '[T]oggle all [L]SP [D]iagnostics o[F]f' },
    },
    config = function()
      require('toggle_lsp_diagnostics').init()
    end,
  }
}

-- vim: sw=2 et
