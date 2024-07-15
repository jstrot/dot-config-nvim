require("config.jst-visuals")
require("config.jst-mappings")
require("config.jst-lsp")

-- Use full wildmenu functionality but only complete to longest common string
vim.opt.wildmode = { "longest:full" }

-- Wrapped lines makes it hard to read
vim.opt.wrap = false

-- Reuse windows
if false then
	-- I don't use tabs, but this could be useful
	vim.opt.switchbuf = "usetab"
else
	vim.opt.switchbuf = "useopen"
end

-- For vim old-timers, disable autoread
vim.opt.autoread = false
-- Workaround file change detection on resume (https://github.com/neovim/neovim/issues/2127)
vim.cmd([[autocmd BufEnter,VimResume * checktime]])

-- I don't like to lose sight of modified buffers.
vim.opt.hidden = false

-- Default smart indentation
vim.opt.expandtab = true

vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.autoindent = true

-- Always break hard links!!
vim.opt.backupcopy = { "auto", "breakhardlink" }

-- Toggle 'paste' mode using \p
vim.cmd([[map <leader>p :set paste! paste? <cr>]])

-- Toggle 'signcolumn' mode using \s
vim.cmd([[
function ToggleSignColumn()
  let &signcolumn = &signcolumn == "no" ? "yes" : "no"
  set signcolumn?
endfunction
map <leader>s :call ToggleSignColumn() <cr>
]])

-- Tip #709 - If you create lots of shell scripts
if vim.fn.has("unix") == 1 then
	vim.cmd([[
  au BufWritePost * if
        \ expand("%:e") != "in" &&
        \ getline(1) =~# '^#!\(/[[:alnum:]._-]\+\)*/bin/[[:alnum:]._-]\+\>' &&
        \ ! executable(expand("%:p"))
        \ | exec "silent !chmod u+x <afile>" | endif
]])
end

-- Cscope: quickfix, autoload and mappings
if vim.fn.has("cscope") == 1 then
	vim.cmd([[
    if executable(&cscopeprg)
	"set cscopeprg=/usr/local/bin/cscope

	set cscopequickfix=
	set cscopequickfix+=c-
	set cscopequickfix+=d-
	set cscopequickfix+=e-
	set cscopequickfix+=f0
	set cscopequickfix+=g0
	set cscopequickfix+=i-
	set cscopequickfix+=s-
	set cscopequickfix+=t-
	set cscopetag
	set cscopetagorder=0
	set cscopepathcomp=0

	set nocscopeverbose
	cscope reset
	if $CSCOPE_DB != ""
	    " add database pointed to by environment
	    cscope add $CSCOPE_DB
	elseif filereadable("cscope.out")
	    " else add any database in current directory
	    cscope add cscope.out
	endif
	set cscopeverbose

	nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

    endif
]])
end
