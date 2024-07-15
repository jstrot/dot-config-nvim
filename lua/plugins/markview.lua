-- https://github.com/OXY2DEV/markview.nvim
return {
  'OXY2DEV/markview.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function ()
    require("markview").setup();
  end

}

-- vim: sw=2 et
