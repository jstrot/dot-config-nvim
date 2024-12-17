-- https://github.com/lambdalisue/gin.vim
return {
  {
    'lambdalisue/gin.vim',
    enabled = false,  -- TODO: XXXJST Not enabling due to Deno dependency
    event = 'VeryLazy',
    dependencies = { 'vim-denops/denops.vim' },
  }
}

-- vim: sw=2 et
