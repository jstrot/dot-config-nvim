-- https://github.com/ggml-org/llama.vim
require("jst.ai.config")

local llama_config = {

  -- Define profiles in lua/config/ai.lua
  profiles = vim.g.llama_vim_profiles,
  profile = "default",

  -- [[ Models ]]
  -- Llama.vim is limited to a single model name for FIM and Instructions (Chat).
  -- You need to make the same model name available on every one of your
  -- profiles/servers.
  model_fim = 'default-fim',
  model_inst = 'default-fim',

  -- [[ Keymaps ]]
  keymap_fim_accept_full = "<Tab>",
  keymap_fim_accept_line = "<M-C-Right>",
  keymap_fim_accept_word = "<M-right>",
  keymap_fim_next = "<M-]>",
  keymap_fim_prev = "<M-[>",
  keymap_fim_trigger = "", -- "<leader>llf", -- manual trigger? Must work in insert mode
  keymap_inst_trigger = "", -- "<leader>lli",
  keymap_inst_rerun = "", -- "<leader>llr",
  keymap_inst_continue = "", -- "<leader>llc",
  keymap_inst_accept = "", -- "<Tab>",
  keymap_inst_cancel = "", -- "<Esc>",
  keymap_debug_toggle = "", -- "<leader>lld",

  auto_fim = true,
  enable_at_startup = true,
  show_info = 0, -- Verbosity of stats shown on FIM line (0-2)
  -- api_key = '',
  -- n_prefix = 256,
  -- n_suffix = 64,
  -- n_predict = 128,
  -- stop_strings_fim = {},
  -- stop_strings_inst = {},
  -- n_cmpl = 1,
  -- t_max_prompt_ms = 500,
  -- t_max_predict_ms = 1000,
  -- info_compact = 3,
  -- max_line_suffix = 8,
  -- max_cache_keys = 250,
  -- ring_n_chunks = 16,
  -- ring_chunk_size = 64,
  -- ring_scope = 1024,
  -- ring_update_ms = 1000,

}

return {
  {
    "ggml-org/llama.vim",
    enabled = not vim.tbl_isempty(llama_config.profiles),
    cond = vim.g.auto_suggest_completion_plugin == "llama.vim",
    lazy = false,
    init = function()
      vim.g.llama_config = llama_config
    end,
    cmd = {
      'LlamaDisable',
      'LlamaEnable',
      'LlamaToggle',
      'LlamaToggleAutoFim',
      'LlamaProfile',
      'LlamaProfileReset',
      'LlamaInstruct',
      'LlamaDebugClear',
      'LlamaDebugToggle',
    },
  },
}

-- vim: sw=2 et
