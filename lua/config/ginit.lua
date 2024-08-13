-- See list of GUIs: https://neovim.io/

vim.o.guifont = "DroidSansM Nerd Font:h14"

-- Neovim-qt: https://github.com/equalsraf/neovim-qt
if vim.fn.exists(':GuiFont') then
  vim.cmd.GuiFont(vim.o.guifont)
end
if vim.fn.exists(':GuiAdaptiveColor') then
  vim.cmd.GuiAdaptiveColor(1)
end
if vim.fn.exists(':GuiScrollBar') then
  vim.cmd.GuiScrollBar(1)
end
if vim.fn.exists(':GuiShowContextMenu') then
  -- Context menu on mouse right-click
  vim.keymap.set('n', '<silent><RightMouse>', ':call GuiShowContextMenu()<CR>', { noremap = true, desc = 'Open context menu' })
  vim.keymap.set('i', '<silent><RightMouse>', '<Esc>:call GuiShowContextMenu()<CR>', { noremap = true, desc = 'Open context menu' })
  vim.keymap.set('x', '<silent><RightMouse>', ':call GuiShowContextMenu()<CR>gv', { noremap = true, desc = 'Open context menu' })
  vim.keymap.set('s', '<silent><RightMouse>', '<C-G>:call GuiShowContextMenu()<CR>gv', { noremap = true, desc = 'Open context menu' })
end

-- Neovide: https://neovide.dev/configuration.html
if vim.g.neovide then
  vim.g.neovide_theme = 'auto'
end

-- Shift-Insert pastes the X11 CLIPBOARD
vim.keymap.set({'i', 'c'}, '<S-Insert>', '<C-R>+', { desc = 'Insert the content of the clipboard(+)' })

-- vim: sw=2 et
