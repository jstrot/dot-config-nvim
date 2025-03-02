-- https://github.com/jalvesaq/dict.nvim
-- Install dictionaries:
--
--     sudo apt install dict dictd dict-wn dict-gcide
--     sudo apt install dict-freedict-fra-eng dict-freedict-eng-fra dict-freedict-eng-hin dict-freedict-eng-jpn
return {
  {
    "jalvesaq/dict.nvim",
    keys = {
      {
        "<leader>id",
        function()
          require("dict").lookup()
        end,
        desc = "[I]nspect word in [D]ictionary",
      },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
  },
}

-- vim: sw=2 et
