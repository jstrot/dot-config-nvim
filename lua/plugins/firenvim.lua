-- https://github.com/glacambre/firenvim
--[[ HOWTO:

1. Install the browser extension too:
- Firefox: https://addons.mozilla.org/en-US/firefox/addon/firenvim/
- Chrome: https://chromewebstore.google.com/detail/firenvim/egpjdkipkomnmjhjmdamaniclmdlobbo

2. (optional) Setup a browser shortcut
- Firefox: Shortcuts menu in about://addons
- Chrome: chrome://extensions/shortcuts
Suggestion: Set the "Turn the currently focused element into a neovim iframe." shortcut to Ctrl-E.

If you don't want to use a shortcut, then set `takeover = 'always'` below so all textareas are handled by Neovim.

Click on browser textarea fields, press the shortcut, edit with Neovim and save+close with `:wq` or `ZZ`.

See also: `:help firenvim-how-to-use`
NOTE: If you make changes to the configuration here, click on the extension's icon in the browser and then on "Reload settings".

--]]
return {
  {
    "glacambre/firenvim",
    build = ":call firenvim#install(0)",
    enabled = false, -- Opt-in: Enable if you want to use this browser extension
    lazy = not vim.g.started_by_firenvim,
    config = function()
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        -- pattern = 'github.com_*.txt',
        pattern = "*.txt",
        callback = function()
          vim.o.filetype = "markdown"
        end,
      })

      -- vim.go.laststatus = laststatus
      vim.api.nvim_create_autocmd({ "UIEnter" }, {
        callback = function(event)
          local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
          if client ~= nil and client.name == "Firenvim" then
            vim.o.laststatus = 1 -- show the status line only if there are at least two windows
          end
        end,
      })

      vim.g.firenvim_config = {
        globalSettings = {
          alt = "all",
        },
        localSettings = {
          [".*"] = { -- URL regular expression, such as '^https?://github.com/'
            priority = 0, -- The matching rule with highest priority wins.
            cmdline = "firenvim", -- firenvim (clean, less waste), neovim (default), none (needs a separate method)
            content = "text",
            selector = 'textarea:not([rows="1"], [readonly], [aria-readonly]), div[role="textbox"]',
            --[[ Configuring Firenvim to not always take over elements
            - 'always': Firenvim will always take over elements for you.
            - 'empty': Firenvim will only take over empty elements.
            - 'never': Firenvim will never automatically appear, thus forcing you to use a keyboard shortcut in order to make the Firenvim frame appear.
            - 'nonempty': Firenvim will only take over elements that aren't empty.
            - 'once': Firenvim will take over elements the first time you select them, which means that after :q'ing Firenvim, you'll have to use the keyboard shortcut to make it appear again.
            --]]
            takeover = "never",
          },
        },
      }
    end,
  },
}

-- vim: sw=2 et
