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
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = false
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Configure how new splits should be opened
-- false+false let's your eyes stay focused on the cursor when splitting
vim.o.splitright = false
vim.o.splitbelow = false

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = false  -- Enabling this can interfere with xterm copy-pasting.
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 6

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']e', function () vim.diagnostic.goto_next({severity = 'error'}) end, { desc = 'Go to next diagnostic [E]rror message' })
vim.keymap.set('n', '[e', function () vim.diagnostic.goto_prev({severity = 'error'}) end, { desc = 'Go to previous diagnostic [E]rror message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' })

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

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

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
  -- Also set the PATH environment so tools will use this python3 version (Mason, for example, doesn't use `vim.g.python3_host_prog` anymore)
  vim.env.PATH = vim.env.HOME .. '/.pyenv/versions/neovim/bin:' .. vim.env.PATH
end

-- Sane defaults
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 8
vim.o.softtabstop = -1 -- negative values use shiftwidth value

-- Speed up
vim.o.lazyredraw = true

-- Reuse windows
if false then
  -- I don't use tabs, but this could be useful
  vim.opt.switchbuf = { 'usetab', 'uselast' }
else
  vim.opt.switchbuf = { 'useopen', 'uselast' }
end

-- I don't like to lose sight of modified buffers...
vim.o.hidden = false

-- For vim old-timers, disable autoread
vim.o.autoread = false
-- Workaround file change detection on resume (https://github.com/neovim/neovim/issues/2127)
vim.cmd([[autocmd BufEnter,VimResume * checktime]])

-- Always break hard links!!
vim.opt.backupcopy = { 'auto', 'breakhardlink' }

-- Quickfix keymaps
vim.keymap.set('n', '[q', ':cprev<CR>zv', { noremap = true, silent = true, desc = 'Go to previous [Q]uickfix position' })
vim.keymap.set('n', ']q', ':cnext<CR>zv', { noremap = true, silent = true, desc = 'Go to next [Q]uickfix position' })
vim.keymap.set('n', '<f4>', ':cnext<CR>zv', { noremap = true, silent = true, desc = 'Go to next [Q]uickfix position' })

function ToggleBoolOpt(option)
  vim.o[option] = not vim.o[option]
  vim.notify('Toggle ' .. option .. ': ' .. vim.inspect(vim.o[option]))
end
function ToggleSubOpt(option, subopt)
  if string.find(vim.o[option], subopt) then
    vim.o[option]:remove(subopt)
  else
    vim.o[option]:append(subopt)
  end
  vim.notify('Toggle ' .. option .. ' ' .. subopt .. ': ' .. vim.o[option])
end

vim.keymap.set('n', '<leader>tp', function () ToggleBoolOpt('paste') end, { desc = '[T]oggle [P]aste mode' })
vim.keymap.set('n', '<leader>t=', function () ToggleBoolOpt('spell') end, { desc = '[T]oggle spell mode' })
vim.keymap.set('n', '<leader>tw', function () ToggleBoolOpt('wrap') end, { desc = '[T]oggle [W]rap mode' })

-- Toggle 'signcolumn' mode using `<leader>ts...`
function ToggleSignColumn(width)
  local win_id = vim.api.nvim_get_current_win()
  if width then
    if width == 0 then
      if vim.wo.signcolumn ~= 'no' then
        vim.api.nvim_win_set_var(win_id, "saved_signcolumn", vim.wo.signcolumn)
        vim.wo.signcolumn = 'no'
      end
    elseif width == 1 then
      vim.wo.signcolumn = 'yes'
    else
      vim.wo.signcolumn = 'yes:' .. tostring(width)
    end
  else
    if vim.wo.signcolumn == 'no' then
      local ok, saved_signcolumn = pcall(vim.api.nvim_win_get_var, win_id, "saved_signcolumn")
      vim.wo.signcolumn = (ok and saved_signcolumn) or 'yes'
    else
      vim.api.nvim_win_set_var(win_id, "saved_signcolumn", vim.wo.signcolumn)
      vim.wo.signcolumn = 'no'
    end
  end
  vim.notify('Toggle signcolumn: ' .. vim.inspect(vim.wo.signcolumn))
end
vim.keymap.set('n', '<leader>ts<cr>', ToggleSignColumn, { desc = '[T]oggle [S]ign column' })
vim.keymap.set('n', '<leader>ts0', function () ToggleSignColumn(0) end, { desc = '[T]oggle [S]ign column: [0] wide (no/off)' })
vim.keymap.set('n', '<leader>ts1', function () ToggleSignColumn(1) end, { desc = '[T]oggle [S]ign column: [1] wide' })
vim.keymap.set('n', '<leader>ts2', function () ToggleSignColumn(2) end, { desc = '[T]oggle [S]ign column: [2] wide' })
vim.keymap.set('n', '<leader>ts3', function () ToggleSignColumn(3) end, { desc = '[T]oggle [S]ign column: [3] wide' })
vim.keymap.set('n', '<leader>tsn', function () ToggleBoolOpt('number') end, { desc = '[T]oggle [S]ign column line [N]umber' })

-- Toggle 'virtualedit' mode using `<leader>tv`
function ToggleVirtualEdit()
  local win_id = vim.api.nvim_get_current_win()
  local cur_virtualedit = vim.wo.virtualedit
  if cur_virtualedit == "" then
    -- "" uses global value
    cur_virtualedit = vim.o.virtualedit
  end
  if not cur_virtualedit or cur_virtualedit == "" then
    -- nil or "" at global level is the same as "none"
    cur_virtualedit = "none"
  end
  if cur_virtualedit == 'none' then
    local ok, saved_virtualedit = pcall(vim.api.nvim_win_get_var, win_id, "saved_virtualedit")
    vim.wo.virtualedit = (ok and saved_virtualedit) or 'all'
  else
    vim.api.nvim_win_set_var(win_id, "saved_virtualedit", cur_virtualedit)
    vim.wo.virtualedit = 'none'
  end
  vim.notify('Toggle virtualedit: ' .. vim.inspect(vim.wo.virtualedit))
end
vim.keymap.set('n', '<leader>tv', ToggleVirtualEdit, { desc = '[T]oggle [V]irtual edit' })

-- Toggle diff-related options using `<leader>td...`
vim.keymap.set('n', '<leader>td<cr>', function () ToggleBoolOpt('diff') end,             { desc = '[T]oggle [D]iff mode' })
vim.keymap.set('n', '<leader>tdb',    function () ToggleSubOpt('diffopt', 'iblank') end, { desc = '[T]oggle [D]iff ignore [B]lank lines' })
vim.keymap.set('n', '<leader>tdc',    function () ToggleSubOpt('diffopt', 'icase') end,  { desc = '[T]oggle [D]iff ignore [C]ase of text' })
vim.keymap.set('n', '<leader>tdw',    function () ToggleSubOpt('diffopt', 'iwhite') end, { desc = '[T]oggle [D]iff ignore [W]hite spaces' })

-- Toggle diagnostics
local default_diagnostic_opts = {
  underline = true, -- Neovim default is true
  virtual_text = true, -- Neovim default is false
  virtual_lines = false, -- Neovim default is false
  signs = true, -- Neovim default is true
  update_in_insert = false, -- Neovim default is false
  severity_sort = true, -- Neovim default is false. {reverse = true} is also supported
}
vim.diagnostic.config(default_diagnostic_opts)
local function ToggleDiagnosticOpt(opt)
  local new_value = not vim.diagnostic.config()[opt]
  vim.diagnostic.config({ [opt] = new_value })
  vim.notify('Toggle diagnostic ' .. opt .. ': ' .. vim.inspect(new_value))
end
local function DefaultDiagnosticOpts()
  vim.diagnostic.config(default_diagnostic_opts)
  vim.notify('Defaulted diagnostic opts')
end
local function ToggleDiagnostics()
  local new_value = not vim.diagnostic.is_enabled()
  vim.diagnostic.enable(new_value)
  vim.notify('Toggle diagnostics: ' .. vim.inspect(new_value))
end
vim.keymap.set('n', '<leader>tlu', function() ToggleDiagnosticOpt('underline') end, { desc = '[T]oggle [L]SP diagnostics [U]nderline' })
vim.keymap.set('n', '<leader>tls', function() ToggleDiagnosticOpt('signs') end, { desc = '[T]oggle [L]SP diagnostics [S]igns' })
vim.keymap.set('n', '<leader>tsl', function() ToggleDiagnosticOpt('signs') end, { desc = '[T]oggle [S]ign column [L]SP diagnostics' })
vim.keymap.set('n', '<leader>tlv', function() ToggleDiagnosticOpt('virtual_text') end, { desc = '[T]oggle [L]SP diagnostics [V]irtual text' })
vim.keymap.set('n', '<leader>tlV', function() ToggleDiagnosticOpt('virtual_lines') end, { desc = '[T]oggle [L]SP diagnostics [V]irtual lines' })
vim.keymap.set('n', '<leader>tlp', function() ToggleDiagnosticOpt('update_in_insert') end, { desc = '[T]oggle [L]SP diagnostics information u[P]date while in insert mode' })
vim.keymap.set('n', '<leader>tld<cr>', function() ToggleDiagnostics() end, { desc = '[T]oggle all [L]SP diagnostics' })
vim.keymap.set('n', '<leader>tldd', function() DefaultDiagnosticOpts() end, { desc = '[T]oggle all [L]SP diagnostics back to [D]efaults (on, except overrides passed on init)' })
vim.keymap.set('n', '<leader>tldo', function() vim.diagnostic.enable(true) end, { desc = '[T]oggle all [L]SP [D]iagnostics [O]n' })
vim.keymap.set('n', '<leader>tldf', function() vim.diagnostic.enable(false) end, { desc = '[T]oggle all [L]SP [D]iagnostics o[F]f' })

vim.opt.diffopt:append('closeoff')
vim.opt.diffopt:append('hiddenoff')
vim.opt.diffopt:append('indent-heuristic')
-- vim.opt.diffopt:append('linematch:60') -- Breaks `do]c` motion macros

-- Visual searching
vim.o.incsearch = true

-- Start horizontal scrolling before context runs out
vim.o.sidescrolloff = 5

-- Wrapped lines makes it hard to read, but breakindent makes this good again
vim.o.wrap = vim.o.breakindent

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

-- NOTE: Enable this to silence *temporarily* deprecated commands warning
-- vim.deprecate = function() end

-- [[ Make plugin choices ]]
vim.g.cmp_plugin = vim.fn.has('nvim-0.10.0') == 1 and 'blink.cmp' or 'nvim-cmp' -- 'blink.cmp', 'nvim-cmp'
vim.g.picker_plugin = vim.fn.has('nvim-0.9.4') == 1 and 'snacks.picker' or 'telescope' -- 'snacks.picker', 'telescope'

-- [[ Configure and install plugins ]]
require('config.lazy')

-- vim.cmd 'colorscheme onedarker'  -- From LazyVim/Colorschemes
vim.cmd 'colorscheme catppuccin'  -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
-- vim.cmd 'colorscheme tokyonight-night'  -- tokyonight (=> tokyonight-moon), tokyonight-night, tokyonight-storm, tokyonight-day (light)

-- Colorscheme fixups?
if vim.g.colors_name == 'onedarker' then
  -- onedarker doesn't set NonText so stuff like gitsigns's blame virtual text doesn't show
  local c = require('onedarker.palette')
  vim.api.nvim_set_hl(0, 'NonText', { fg = c.dark_gray, bg = 'NONE', italic = true })
end

-- JSON: Disable default syntax highlighting concealment
-- vim.g.vim_json_conceal = 0

-- Default is 'nc' which makes it hard to predict moves required to edit the current line or search matching patterns.
-- Conceiling only in visual mode makes it more consistent, IMO.
vim.o.concealcursor = 'v'

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.shiftwidth = 2 -- I prefer a more compact view. vim-sleuth will auto-adapt for existing files.
  end
})

-- vim: sw=2 et
