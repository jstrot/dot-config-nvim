
-- Quickfix navigation
vim.keymap.set('n', ']q', ':cnext<CR>zv', { noremap = true, silent = true })
vim.keymap.set('n', '[q', ':cprev<CR>zv', { noremap = true, silent = true })
vim.keymap.set('n', '<f4>', ':cnext<CR>zv', { noremap = true, silent = true })

-- Diagnostics navigation (for consistency, see also <leader> versions below)
vim.keymap.set('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })

has_fzflua, fzflua = pcall(require, 'fzf-lua')
if has_fzflua == true then
    vim.keymap.set("n", "<leader>ff", fzflua.files, {}, { silent = true })
    vim.keymap.set("n", "<leader>fg", fzflua.live_grep, {}, { silent = true })
    vim.keymap.set("n", "<leader>fb", fzflua.buffers, {}, { silent = true })
    vim.keymap.set("n", "<leader>fh", fzflua.help_tags, {}, { silent = true })
    vim.keymap.set("n", "<leader>fr", fzflua.resume, {}, { silent = true })
    -- https://github.com/junegunn/fzf/commit/2069bbc8b54fa77384e42274ee15af7b397af884
    vim.g["fzf_action"] = {
      ["ctrl-t"] = "tab split",
      ["ctrl-x"] = "split",
      ["ctrl-v"] = "vsplit",
      ["ctrl-q"] = "fill_quickfix",
    }
else
    has_telescope, telescope = pcall(require, 'telescope')
    if has_telescope == true then
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fr', builtin.resume, {})
    end
end

-- See https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts/
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
has_fzflua, fzflua = pcall(require, 'fzf-lua')
if has_fzflua == true then
    vim.keymap.set('n', '<leader>dd', fzflua.diagnostics_document, {}, { noremap = true, silent = true })
else
    has_telescope, telescope = pcall(require, 'telescope')
    if has_telescope == true then
        -- The following command requires plug-ins 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', and optionally 'kyazdani42/nvim
        vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
    else
        -- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and
        vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
    end
end

-- https://github.com/folke/trouble.nvim
has_trouble, trouble = pcall(require, 'trouble')
if has_trouble == true then
    vim.keymap.set('n', '<leader>xx', function() require('trouble').open() end)
    vim.keymap.set('n', '<leader>xw', function() require('trouble').open('workspace_diagnostics') end)
    vim.keymap.set('n', '<leader>xd', function() require('trouble').open('document_diagnostics') end)
    vim.keymap.set('n', '<leader>xl', function() require('trouble').open('quickfix') end)
    vim.keymap.set('n', '<leader>xq', function() require('trouble').open('loclist') end)
    vim.keymap.set('n', 'gR', function() require('trouble').open('lsp_references') end)

    has_telescope, telescope = pcall(require, 'telescope')
    if has_telescope == true then
	local actions = require('telescope.actions')
	local trouble = require('trouble.providers.telescope')

	-- XXXJST TODO Can this be clled again?
	telescope.setup {
	    defaults = {
		mappings = {
		    i = { ['<c-t>'] = require("trouble.sources.telescope").open },
		    n = { ['<c-t>'] = require("trouble.sources.telescope").open },
		},
	    },
	}
    end
end

-- has_treesitter_context, treesitter_context = pcall(require, 'treesitter-context')
-- if has_treesitter_context == true then
--     vim.keymap.set('n', '[c', function() treesitter_context.go_to_context() end, { silent = true })
-- end
