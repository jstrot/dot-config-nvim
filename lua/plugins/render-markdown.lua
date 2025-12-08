-- https://github.com/MeanderingProgrammer/render-markdown.nvim
local jst_md = require('jst.markdown')

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- enabled = false,
    lazy = true, -- On-demand only
    ft = jst_md.markdown_filetypes_per_plugin['render-markdown'] or {},
    opts = {
      anti_conceal = { enabled = false },
      file_types = jst_md.markdown_filetypes_per_plugin['render-markdown'] or {},
    },
  },
}

-- vim: sw=2 et
