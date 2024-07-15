-- TODO vim.cmd('source ~/.config/nvim/extra-init.vim')

require('config.lazy')

-- TEMP
-- vim.deprecate = function() end

local ok, _ = pcall(vim.cmd, 'colorscheme onedarker')
if ok then
  -- onedarker doesn't set NonText so 
  local c = require('onedarker.palette')
  vim.api.nvim_set_hl(0, "NonText", { fg = c.dark_gray, bg = 'NONE', italic = true })
else
  vim.cmd 'colorscheme default' -- if the above fails, then use default
end

-- Sane defaults
vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require('config.jst-lsp')
require("config.jst-coc")
require('config.jst-cmp')
require('config.jst-visuals')

-- require('config.jst-way')

-- require('config.llama-copilot')
require('config.llm')

-- vim: sw=2 et
