-- https://github.com/MeanderingProgrammer/render-markdown.nvim
jst_md = require('jst.markdown')

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- enabled = false,
    lazy = true, -- On-demand only
    opts = {
      anti_conceal = { enabled = false },
      file_types = jst_md.markdown_filetypes_per_plugin['render-markdown'],
    },
    ft = jst_md.markdown_filetypes_per_plugin['render-markdown'],
  },
}

-- vim: sw=2 et
