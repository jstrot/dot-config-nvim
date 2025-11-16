require('jst.ai.config')

return {
  {
    -- https://github.com/copilotlsp-nvim/copilot-lsp
    "copilotlsp-nvim/copilot-lsp",
    enabled = vim.g.next_edit_suggestion_plugin == 'copilot-lsp',
    -- TODO: Blink integration: https://github.com/copilotlsp-nvim/copilot-lsp?tab=readme-ov-file#blink-integration
    -- TODO: Blink-copilot: https://github.com/fang2hou/blink-copilot
    opts = {
      nes = {
        move_count_threshold = 3,   -- Clear after 3 cursor movements
      }
    },
    init = function()
      vim.g.copilot_nes_debounce = 500
      vim.lsp.enable("copilot_ls")
      vim.keymap.set("n", "<tab>", function()
        if true then
          local bufnr = vim.api.nvim_get_current_buf()
          local state = vim.b[bufnr].nes_state
          if state then
            -- Try to jump to the start of the suggestion edit.
            -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
            local _ =
              require("copilot-lsp.nes").walk_cursor_start_edit()
              or (
                require("copilot-lsp.nes").apply_pending_nes()
                and require("copilot-lsp.nes").walk_cursor_end_edit()
              )
            return nil
          else
            -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
            return "<C-i>"
          end
        else
          -- Try to jump to the start of the suggestion edit.
          -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
          local _ =
            require("copilot-lsp.nes").walk_cursor_start_edit()
            or (
              require("copilot-lsp.nes").apply_pending_nes()
              and require("copilot-lsp.nes").walk_cursor_end_edit()
            )
        end
      end, { desc = "Accept Copilot NES suggestion", expr = true })
    end,

  },
}

-- vim: sw=2 et
