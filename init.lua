-- [[ START OF kickstart.nvim SECTION ]]
-- Based on https://github.com/nvim-lua/kickstart.nvim

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = false
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false  -- Enabling this can interfere with xterm copy-pasting.
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 6

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- The above mappings may be overridden by vim-tmux-navigator, if enabled.

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ END OF kickstart.nvim SECTION ]]

local uv = vim.uv or vim.loop
if uv.fs_stat(vim.env.HOME .. '/.pyenv/versions/neovim/bin/python') then
  vim.g.python3_host_prog = vim.env.HOME .. '/.pyenv/versions/neovim/bin/python'
end

-- Sane defaults
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 8

-- Reuse windows
if false then
  -- I don't use tabs, but this could be useful
  vim.opt.switchbuf = { 'usetab', 'uselast' }
else
  vim.opt.switchbuf = { 'useopen', 'uselast' }
end

-- I don't like to lose sight of modified buffers...
vim.opt.hidden = false
-- ... and please confirm instead of failing operations on unsaved buffers.
vim.opt.confirm = true

-- For vim old-timers, disable autoread
vim.opt.autoread = false
-- Workaround file change detection on resume (https://github.com/neovim/neovim/issues/2127)
vim.cmd([[autocmd BufEnter,VimResume * checktime]])

-- Always break hard links!!
vim.opt.backupcopy = { 'auto', 'breakhardlink' }

-- Quickfix keymaps
vim.keymap.set('n', '[q', ':cprev<CR>zv', { noremap = true, silent = true, desc = 'Go to previous [Q]uickfix position' })
vim.keymap.set('n', ']q', ':cnext<CR>zv', { noremap = true, silent = true, desc = 'Go to next [Q]uickfix position' })
vim.keymap.set('n', '<f4>', ':cnext<CR>zv', { noremap = true, silent = true, desc = 'Go to next [Q]uickfix position' })

-- Toggle 'paste' mode using \tp
vim.keymap.set('n', '<leader>tp', ':set paste! paste?<CR>', { desc = '[T]oggle [P]aste mode' })

-- Toggle 'signcolumn' mode using \ts
function ToggleSignColumn()
  local win_id = vim.api.nvim_get_current_win()
  if vim.wo.signcolumn == 'no' then
    local _, saved_signcolumn = pcall(vim.api.nvim_win_get_var, win_id, "saved_signcolumn")
    vim.wo.signcolumn = saved_signcolumn or 'yes'
  else
    vim.api.nvim_win_set_var(win_id, "saved_signcolumn", vim.wo.signcolumn)
    vim.wo.signcolumn = 'no'
  end
  print(vim.wo.signcolumn)
end
vim.keymap.set('n', '<leader>ts', ':lua ToggleSignColumn()<CR>', { desc = '[T]oggle [S]ign column' })

-- Visual searching
vim.opt.incsearch = true

-- Start horizontal scrolling before context runs out
vim.opt.sidescrolloff = 5

-- Wrapped lines makes it hard to read, but breakindent makes this good again
vim.opt.wrap = not not vim.opt.breakindent  -- `not not` to avoid "must be the same value, otherwise that's weird!" error

-- Tip #709 - If you create lots of shell scripts, this will make them executable
if vim.fn.has('unix') == 1 then
  vim.cmd([[
  au BufWritePost * if
  \ expand('%:e') != 'in' &&
  \ getline(1) =~# '^#!\(/[[:alnum:]._-]\+\)*/bin/[[:alnum:]._-]\+\>' &&
  \ ! executable(expand('%:p'))
  \ | exec 'silent !chmod u+x <afile>' | endif
]])
end

-- Use full wildmenu functionality but only complete to longest common string
vim.opt.wildmode = { 'longest:full' }

-- [[ Configure and install plugins ]]
require('config.lazy')

local ok, _ = pcall(vim.cmd, 'colorscheme onedarker')
if ok then
  -- onedarker doesn't set NonText so stuff like gitsigns's blame virtual text doesn't show
  local c = require('onedarker.palette')
  vim.api.nvim_set_hl(0, 'NonText', { fg = c.dark_gray, bg = 'NONE', italic = true })
else
  vim.cmd 'colorscheme default' -- if the above fails, then use default
end

-- vim: sw=2 et
