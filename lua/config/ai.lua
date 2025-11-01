
--[[ GitHub Copilot ]]
-- Auto-suggest completion + Chat.
-- Cloud. Free + paid tiers.
--
-- Once enabled, restart Neovim and run `:Copilot` to setup
--
-- Plugins:
-- - lua/plugins/Copilot.lua
-- - lua/plugins/CopilotChat.lua

vim.g.github_copilot_enabled = true -- Main switch
vim.g.github_copilot_active = true -- Turn off temporarily if your free plan runs out
vim.g.github_copilot_chat_model = nil -- nil for default, `:CopilotChatModels` to pick or list of models
vim.g.github_copilot_code_model = nil -- nil for default
vim.g.github_copilot_agent_model = nil -- nil for default

-- vim.g.agentic_mode_plugin = 'codecompanion'
-- vim.g.agentic_mode_plugin = 'avante' -- Quite good, but doesn't support some industry standard features
vim.g.agentic_mode_plugin = 'opencode' -- Recommended

--[[ Ollama ]]
-- Auto-suggest completion.
-- Self-hosted. Free.
--
-- Plugins:
-- - lua/plugins/llm.lua
-- - lua/plugins/ogpt.lua

vim.g.ollama_url_env = 'OLLAMA_API_HOST' -- or 'OLLAMA_HOST'
vim.g.ollama_url_file = vim.env.HOME .. '/.OLLAMA_API_HOST'
vim.g.ollama_token_env = 'OLLAMA_API_KEY' -- optional
vim.g.ollama_token_file = vim.env.HOME .. '/.OLLAMA_API_KEY' -- optional
vim.g.ollama_code_model_env = 'OLLAMA_MODEL_CODE'
vim.g.ollama_code_model_file = vim.env.HOME .. '/.OLLAMA_MODEL_CODE'
vim.g.ollama_code_model = 'starcoder2:3b' -- Fast, very simplistic suggestions.
vim.g.ollama_code_model = 'starcoder2:7b' -- Fast, very simplistic suggestions.
vim.g.ollama_code_model = 'codellama:7b-code' -- Slow, good suggestions, some `<fim_end>` showing.
vim.g.ollama_code_model = 'hf.co/bartowski/zed-industries_zeta-GGUF:Q4_K_M' -- Zeta, based on Qwen2.5-Coder-7B to support edit prediction in Zed editor. Quantized version in GGUF format
vim.g.ollama_chat_model_env = 'OLLAMA_MODEL_CHAT'
vim.g.ollama_chat_model_file = vim.env.HOME .. '/.OLLAMA_MODEL_CHAT'
vim.g.ollama_chat_model = 'mistral:7b'
vim.g.ollama_chat_model = 'phi3:3.8b'
vim.g.ollama_chat_model = 'deepseek-coder:1.3b'
vim.g.ollama_chat_model = 'deepseek-coder:6.7b'
vim.g.ollama_chat_model = 'deepseek-coder-v2:16b'
vim.g.ollama_chat_model = 'gpt-oss:20b'
vim.g.ollama_chat_model = 'gpt-oss:20b-64k'

--[[ Hugging Face (TextGenUI) ]]
-- Auto-suggest completion + Chat.
-- Cloud. Free + paid tiers.
--
-- Plugins:
-- - lua/plugins/llm.lua
-- - lua/plugins/ogpt.lua

vim.g.huggingface_token_env = 'HF_API_KEY'
vim.g.huggingface_token_file = vim.env.HF_HOME and vim.env.HF_HOME .. '/token'
vim.g.huggingface_code_model_env = 'HF_MODEL_CODE'
vim.g.huggingface_code_model = 'bigcode/starcoder2-15b'
vim.g.huggingface_chat_model_env = 'HF_MODEL_CHAT'
vim.g.huggingface_chat_model = 'bigcode/starcoder2-15b'

--[[ OpenAI ]]
-- Auto-suggest completion + Chat.
-- Cloud. Free + paid tiers.
--
-- Plugins:
-- - lua/plugins/ChatGPT.lua

vim.g.openai_url_env = 'OPENAI_API_HOST'
vim.g.openai_url_file = vim.env.HOME .. '/.OPENAI_API_HOST'
vim.g.openai_token_env = 'OPENAI_API_KEY'
vim.g.openai_token_file = vim.env.HOME .. '/.OPENAI_API_KEY'
vim.g.openai_code_model_env = 'OPENAI_MODEL_CODE'
vim.g.openai_code_model_file = vim.env.HOME .. '/.OPENAI_MODEL_CODE'
vim.g.openai_code_model = 'gpt-4.1'
vim.g.openai_chat_model_env = 'OPENAI_MODEL_CHAT'
vim.g.openai_chat_model_file = vim.env.HOME .. '/.OPENAI_MODEL_CHAT'
vim.g.openai_chat_model = 'gpt-4.1'

--[[ state ]]
vim.g.auto_suggest_completion_plugin = nil -- let it pick one
-- vim.g.auto_suggest_completion_plugin = 'copilot' -- Tim Pope's official plugin, stable but slower
-- vim.g.auto_suggest_completion_plugin = 'copilot-lua' -- Zach Birenbaum's pure Lua replacement
-- vim.g.auto_suggest_completion_plugin = 'copilot-lsp'
-- vim.g.auto_suggest_completion_plugin = 'llm' -- Hugging Face's LLM plugin using llm-ls
-- vim.g.auto_suggest_completion_plugin = 'codecompanion' -- Ollio Morris's CodeCompanion
-- vim.g.auto_suggest_completion_plugin = 'avante' -- yetone's Avante -- NOTE: Prefer copilot/copilot-lua unless you want a different provider than Copilot
