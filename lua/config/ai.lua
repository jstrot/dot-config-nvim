--
-- This file contains AI configuration options.
-- Preferably, use environment variables and files to set your preferred AI
-- providers such that all your applications use the same AI provider.
--
-- To determine the final configuration, run `:checkhealth jst.ai`
--

--[[ GitHub Copilot ]]
-- Auto-suggest completion + Chat.
-- Cloud. Free + paid tiers.
--
-- Once enabled, restart Neovim and run `:Copilot` to setup
--
-- Plugins:
-- - lua/plugins/Copilot-vim.lua
-- - lua/plugins/Copilot-lua.lua
-- - lua/plugins/CopilotChat.lua
-- - lua/plugins/codecompanion.lua
-- - lua/plugins/avante.lua
-- - lua/plugins/opencode-tui.lua
-- - lua/plugins/opencode-native.lua

vim.g.github_copilot_enabled = true -- Main switch
vim.g.github_copilot_active = true -- Turn off temporarily if your free plan runs out
vim.g.github_copilot_chat_model = nil -- nil for default, `:CopilotChatModels` to pick or list of models
vim.g.github_copilot_code_model = nil -- nil for default
vim.g.github_copilot_agent_model = nil -- nil for default

--[[ Ollama ]]
-- Auto-suggest completion.
-- Self-hosted. Free. Paid cloud option.
--
-- Plugins:
-- - lua/plugins/llm.lua
-- - lua/plugins/ogpt.lua
-- - lua/plugins/codecompanion.lua
-- - lua/plugins/avante.lua
-- - lua/plugins/opencode-tui.lua
-- - lua/plugins/opencode-native.lua
-- - lua/plugins/cmp-ai.lua (DEPRECATED)

vim.g.ollama_url_env = 'OLLAMA_API_HOST'
vim.g.ollama_url_env2 = 'OLLAMA_HOST'
vim.g.ollama_url_file = '~/.OLLAMA_API_HOST'
vim.g.ollama_token_env = 'OLLAMA_API_KEY' -- optional
vim.g.ollama_token_file = '~/.OLLAMA_API_KEY' -- optional
vim.g.ollama_code_model_env = 'OLLAMA_MODEL_CODE'
vim.g.ollama_code_model_file = '~/.OLLAMA_MODEL_CODE'
vim.g.ollama_code_model = nil
vim.g.ollama_chat_model_env = 'OLLAMA_MODEL_CHAT'
vim.g.ollama_chat_model_file = '~/.OLLAMA_MODEL_CHAT'
vim.g.ollama_chat_model = nil
vim.g.ollama_agent_model_env = 'OLLAMA_MODEL_AGENT'
vim.g.ollama_agent_model_file = '~/.OLLAMA_MODEL_AGENT'
vim.g.ollama_agent_model = nil

--[[ Hugging Face (TextGenUI) ]]
-- Auto-suggest completion + Chat.
-- Cloud. Free + paid tiers.
--
-- Plugins:
-- - lua/plugins/llm.lua
-- - lua/plugins/ogpt.lua
-- - lua/plugins/cmp-ai.lua (DEPRECATED)

vim.g.huggingface_token_env = 'HF_API_KEY'
vim.g.huggingface_token_file = vim.env.HF_HOME and vim.env.HF_HOME .. '/token'
vim.g.huggingface_url_env = 'HF_API_HOST' -- optional
vim.g.huggingface_url_file = '~/.HF_API_HOST' -- optional
vim.g.huggingface_code_model_env = 'HF_MODEL_CODE'
vim.g.huggingface_code_model_file = '~/.HF_MODEL_CODE'
vim.g.huggingface_code_model = nil
vim.g.huggingface_chat_model_env = 'HF_MODEL_CHAT'
vim.g.huggingface_chat_model_file = '~/.HF_MODEL_CHAT'
vim.g.huggingface_chat_model = nil
vim.g.huggingface_agent_model_env = 'HF_MODEL_AGENT'
vim.g.huggingface_agent_model_file = '~/.HF_MODEL_AGENT'
vim.g.huggingface_agent_model = nil

--[[ OpenAI ]]
-- Auto-suggest completion + Chat.
-- Cloud. Free + paid tiers.
--
-- Plugins:
-- - lua/plugins/ChatGPT.lua

vim.g.openai_url_env = 'OPENAI_API_HOST'
vim.g.openai_url_file = '~/.OPENAI_API_HOST'
vim.g.openai_token_env = 'OPENAI_API_KEY'
vim.g.openai_token_file = '~/.OPENAI_API_KEY'
vim.g.openai_code_model_env = 'OPENAI_MODEL_CODE'
vim.g.openai_code_model_file = '~/.OPENAI_MODEL_CODE'
vim.g.openai_code_model = nil
vim.g.openai_chat_model_env = 'OPENAI_MODEL_CHAT'
vim.g.openai_chat_model_file = '~/.OPENAI_MODEL_CHAT'
vim.g.openai_chat_model = nil
vim.g.openai_agent_model_env = 'OPENAI_MODEL_AGENT'
vim.g.openai_agent_model_file = '~/.OPENAI_MODEL_AGENT'
vim.g.openai_agent_model = nil

--[[ Plugin choices ]]

vim.g.agentic_mode_plugin_env = 'JST_AGENTIC_MODE_PLUGIN' -- Use this environment variable for a one-time override
vim.g.agentic_mode_plugin = nil -- let it pick one
-- vim.g.agentic_mode_plugin = 'codecompanion'
-- vim.g.agentic_mode_plugin = 'avante' -- Quite good, but doesn't support some industry standard features
-- vim.g.agentic_mode_plugin = 'opencode-tui' -- Opencode is recommended, requires installing opencode. Opencode TUI in a terminal.
-- vim.g.agentic_mode_plugin = 'opencode-native' -- Opencode is recommended, requires installing opencode. Native Neovim frontend for opencode

vim.g.auto_suggest_completion_plugin_env = 'JST_AUTO_SUGGEST_COMPLETION_PLUGIN' -- Use this environment variable for a one-time override
vim.g.auto_suggest_completion_plugin = nil -- let it pick one
-- vim.g.auto_suggest_completion_plugin = 'copilot' -- Tim Pope's official plugin, stable but slower
-- vim.g.auto_suggest_completion_plugin = 'copilot-lua' -- Zach Birenbaum's pure Lua replacement
-- vim.g.auto_suggest_completion_plugin = 'llm' -- Hugging Face's LLM plugin using llm-ls, supports other providers
-- vim.g.auto_suggest_completion_plugin = 'codecompanion' -- Ollio Morris's CodeCompanion
-- vim.g.auto_suggest_completion_plugin = 'avante' -- yetone's Avante -- NOTE: Prefer copilot/copilot-lua unless you want a different provider than Copilot

-- vim: sw=2 et
