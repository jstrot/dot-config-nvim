local csv_fts = {
  "csv",
  "tsv",
  "csv_semicolon",
  "csv_whitespace",
  "csv_pipe",
  "rfc_csv",
  "rfc_semicolon",
}
return {
  {
    -- https://github.com/mechatroner/rainbow_csv
    -- "mechatroner/rainbow_csv",
    --
    -- https://github.com/cameron-wags/rainbow_csv.nvim
    -- @cameron-wags:
    -- > I love rainbow_csv, but I wanted :RainbowAlign to run faster. Porting
    -- > to lua made it a few times faster.
    -- > If functionality is important to you, please use the original rainbow_csv.
    "cameron-wags/rainbow_csv.nvim",

    ft = csv_fts,
    enabled = true,
    cmd = {
      'RainbowDelim',
      'RainbowDelimSimple',
      'RainbowDelimQuoted',
      'RainbowMultiDelim'
    },
    opts = {},
    config = function(_, opts)
      -- vim.g.rcsv_max_columns = 100
      require("rainbow_csv").setup(opts)
    end
  },
}

-- vim: sw=2 et
