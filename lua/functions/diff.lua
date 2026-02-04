
-- See the differences between the current buffer and the file it was loaded from.
-- See `:DiffOrig`, as this is suggested a suggested solution of the Vim help
vim.cmd [[
    command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
        \ | diffthis | wincmd p | diffthis
]]
