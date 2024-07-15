-- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#vim
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})

return {}

-- vim: sw=2 et
