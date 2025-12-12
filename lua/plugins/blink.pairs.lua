-- https://github.com/Saghen/blink.pairs

local function ToggleKeymaps()
  -- local is_enabled = mappings.is_enabled() -- FIXME: Not accurate if `mappings.enabled` starts disabled
  local is_enabled = require('blink.pairs.config').mappings.enabled == true
  local mappings = require('blink.pairs.mappings')
  if is_enabled then
    require('blink.pairs').setup({mappings = { enabled = false }})
    mappings.disable()
  else
    require('blink.pairs').setup({mappings = { enabled = true }})
    mappings.enable()
  end
  vim.notify('Toggle keymaps for pairs match: ' .. vim.inspect(mappings.is_enabled()))
end

return {
  {
    'Saghen/blink.pairs',

    config = function()

      --[[ Main knobs ]]
      -- Enable this if you want pairs to automatically complete while typing.
      -- You can always use `<leader>tkp` to toggle at runtime
      -- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
      -- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
      local default_keymap_enabled = false

      -- vim.g.pairs = default_keymap_enabled -- FIXME: Would need to toggle this in `ToggleKeymaps` too!

      local pairs = require('blink.pairs')
      --- @module 'blink.pairs'
      --- @type blink.pairs.Config
      local opts = {
        mappings = {
          enabled = default_keymap_enabled,
          cmdline = true, -- Enable in command line mode?
          disabled_filetypes = {},
          -- see the defaults:
          -- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L14
          pairs = {},
        },
        highlights = {
          enabled = true,

          --- Enable in command line mode?
          -- Requires require('vim._extui').enable({}), otherwise has no effect.
          cmdline = true,

          groups =
            -- catppuccin blink.pairs integration:
            vim.g.colors_name:find('catppuccin') and {
              "BlinkPairsRed",
              "BlinkPairsYellow",
              "BlinkPairsBlue",
              "BlinkPairsOrange",
              "BlinkPairsGreen",
              "BlinkPairsPurple",
              "BlinkPairsCyan",
            }
            -- default
            or {
              'BlinkPairsOrange',
              'BlinkPairsPurple',
              'BlinkPairsBlue',
            },
          unmatched_group = 'BlinkPairsUnmatched',

          -- highlights matching pairs under the cursor
          matchparen = {
            enabled = true,

            --- Enable in command line mode?
            -- Requires require('vim._extui').enable({}), otherwise has no effect.
            -- FIXME: known issue where typing won't update matchparen highlight, disabled by default
            cmdline = false,

            --- Also include pairs not on top of the cursor, but surrounding the cursor?
            include_surrounding = false,

            group = 'BlinkPairsMatchParen',
            priority = 250,
          },
        },
        debug = false,
      }
      pairs.setup(opts)
    end,
    keys = {
      vim.keymap.set('n', '<leader>tkp', ToggleKeymaps, { desc = '[T]oggle [K]eymaps for [P]airs matching' })
    },

    version = '*', -- (recommended) only required with prebuilt binaries
    -- download prebuilt binaries from github releases
    dependencies = 'saghen/blink.download',
    -- OR build from source, requires nightly:
    -- https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',
  },
}
