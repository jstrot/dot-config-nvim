-- https://github.com/bullets-vim/bullets.vim
return {
  {
    "bullets-vim/bullets.vim",

    init = function()

      vim.g.bullets_enabled_file_types = {
        --[[ Markdown ]]--
        "markdown",
        "markdown_inline",
        "markdown.mdx",
        "quarto",
        "rmd",
        --[[ Other ]]--
        'text',
        'gitcommit',
        'scratch',
      }

      -- vim.g.bullets_mapping_leader = '<M-b>' -- default = ''

      vim.g.bullets_set_mappings = 0 -- To disable default keymaps and replace with the ones below:
      vim.g.bullets_custom_mappings = {
        {'imap', '<cr>', '<Plug>(bullets-newline)'},
        {'inoremap', '<C-cr>', '<cr>'},

        {'nmap', 'o', '<Plug>(bullets-newline)'},

        {'vmap', 'gN', '<Plug>(bullets-renumber)'},
        {'nmap', 'gN', '<Plug>(bullets-renumber)'},

        {'nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)'},

        {'imap', '<C-Right>', '<Plug>(bullets-demote)'},
        {'nmap', '>>', '<Plug>(bullets-demote)'},
        {'vmap', '>', '<Plug>(bullets-demote)'},

        {'imap', '<C-Left>', '<Plug>(bullets-promote)'},
        {'nmap', '<<', '<Plug>(bullets-promote)'},
        {'vmap', '<', '<Plug>(bullets-promote)'},
      }

      vim.g.bullets_checkbox_markers = ' .oOx' -- empty, <33%, <66%, <100%, completed
      -- vim.g.bullets_checkbox_partials_toggle = 0 -- disable partial checkbox toggling

    end
  },
}

-- vim: sw=2 et
