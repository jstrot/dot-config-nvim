
-- https://github.com/termstandard/colors
if os.getenv('COLORTERM') == 'truecolor'
    or os.getenv('COLORTERM') == '24bit'
then
    vim.opt.termguicolors = true
end
if vim.fn.has('gui_running') == 1
    or vim.opt.termguicolors
    or vim.opt.term.match('%256color')
    or vim.opt.term == 'nvim'
then
    vim.opt.cursorline = true
end

-- Visual searching
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Show plenty of context while scrolling
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 5
-- Fast horizontal scrolling
vim.opt.sidescroll = 0

-- NOTE: Same icons as lualine
local signs = {
    Error = '󰅚 ', -- x000f015a
    Warn  = '󰀪 ', -- x000f002a
    Info  = '󰋽 ', -- x000f02fd
    Hint  = '󰌶 ', -- x000f0336
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- XXXJST TODO override?
-- require('nvim-web-devicons').setup{
-- }
