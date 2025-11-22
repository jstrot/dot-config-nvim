require('config.ai')
local jst = require('jst')

--[[ GitHub Copilot ]]

--- Returns whether GitHub Copilot use is enabled.
-- See also `AI_is_copilot_active`, in case it is temporarily deactivated.
-- @return boolean
function AI_is_copilot_enabled()
  return vim.g.github_copilot_enabled == true
end

--- Returns whether GitHub Copilot use is active.
-- Depends also on `AI_is_copilot_enabled`.
-- @return boolean
function AI_is_copilot_active()
  return AI_is_copilot_enabled() and vim.g.github_copilot_active == true
end

--- Returns GitHub Copilot model to use for Chat sessions.
-- @return string?
function AI_copilot_chat_model()
  return (
    jst.fn.get_secret(vim.g.github_copilot_chat_model_env, vim.g.github_copilot_chat_model_file)
    or vim.g.github_copilot_chat_model
  )
end

--- Returns GitHub Copilot model to use for inline Code suggestions.
-- @return string?
function AI_copilot_code_model()
  return (
    jst.fn.get_secret(vim.g.github_copilot_code_model_env, vim.g.github_copilot_code_model_file)
    or vim.g.github_copilot_code_model
  )
end

--- Returns GitHub Copilot model to use for Agentic AI sessions.
-- @return string?
function AI_copilot_agent_model()
  return (
    jst.fn.get_secret(vim.g.github_copilot_agent_model_env, vim.g.github_copilot_agent_model_file)
    or vim.g.github_copilot_agent_model
  )
end

--[[ Ollama ]]

--- Returns whether Ollama use is enabled.
-- @return boolean
function AI_is_ollama_enabled()
  return AI_ollama_url() ~= nil
end

--- Returns the custom Ollama URL.
-- For local installs, this is "http://127.0.0.1:11434".
-- @return string?
function AI_ollama_url()
  return (
    jst.fn.get_secret(vim.g.ollama_url_env, nil)
    or jst.fn.get_secret(vim.g.ollama_url_env2, vim.g.ollama_url_file)
  )
end

--- Returns the Ollama API key/token (Optional).
-- @return string?
function AI_ollama_api_key()
  return jst.fn.get_secret(vim.g.ollama_token_env, vim.g.ollama_token_file)
end

--- Returns Ollama model to use for Chat sessions.
-- @return string?
function AI_ollama_chat_model()
  return (
    jst.fn.get_secret(vim.g.ollama_chat_model_env, vim.g.ollama_chat_model_file)
    or vim.g.ollama_chat_model
  )
end

--- Returns Ollama model to use for inline Code suggestions.
-- @return string?
function AI_ollama_code_model()
  return (
    jst.fn.get_secret(vim.g.ollama_code_model_env, vim.g.ollama_code_model_file)
    or vim.g.ollama_code_model
  )
end

--- Returns Ollama model to use for Agentic AI sessions.
-- @return string?
function AI_ollama_agent_model()
  return (
    jst.fn.get_secret(vim.g.ollama_agent_model_env, vim.g.ollama_agent_model_file)
    or vim.g.ollama_agent_model
  )
end

--[[ Hugging Face (TextGenUI() ]]

--- Returns whether Hugging Face use is enabled.
-- @return boolean
function AI_is_huggingface_enabled()
  return AI_huggingface_api_key() ~= nil
end

--- Returns the Hugging Face URL (optional).
-- @return string?
function AI_huggingface_url()
  return jst.fn.get_secret(vim.g.huggingface_url_env, vim.g.huggingface_url_file)
end

--- Returns the Hugging Face API key/token.
-- @return string?
function AI_huggingface_api_key()
  return jst.fn.get_secret(vim.g.huggingface_token_env, vim.g.huggingface_token_file)
end

--- Returns Hugging Face model to use for Chat sessions.
-- @return string?
function AI_huggingface_chat_model()
  return (
    jst.fn.get_secret(vim.g.huggingface_chat_model_env, vim.g.huggingface_chat_model_file)
    or vim.g.huggingface_chat_model
  )
end

--- Returns Hugging Face model to use for inline Code suggestions.
-- @return string?
function AI_huggingface_code_model()
  return (
    jst.fn.get_secret(vim.g.huggingface_code_model_env, vim.g.huggingface_code_model_file)
    or vim.g.huggingface_code_model
  )
end

--- Returns Hugging Face model to use for Agentic AI sessions.
-- @return string?
function AI_huggingface_agent_model()
  return (
    jst.fn.get_secret(vim.g.huggingface_agent_model_env, vim.g.huggingface_agent_model_file)
    or vim.g.huggingface_agent_model
  )
end

--[[ OpenAI ]]

--- Returns whether OpenAI use is enabled.
-- @return boolean
function AI_is_openai_enabled()
  return AI_openai_api_key() ~= nil
end

--- Returns the OpenAI URL.
-- @return string?
function AI_openai_url()
  return jst.fn.get_secret(vim.g.openai_url_env, vim.g.openai_url_file)
end

--- Returns the OpenAI API key/token.
-- @return string?
function AI_openai_api_key()
  return jst.fn.get_secret(vim.g.openai_token_env, vim.g.openai_token_file)
end

--- Returns OpenAI model to use for Chat sessions.
-- @return string?
function AI_openai_chat_model()
  return (
    jst.fn.get_secret(vim.g.openai_chat_model_env, vim.g.openai_chat_model_file)
    or vim.g.openai_chat_model
  )
end

--- Returns OpenAI model to use for inline Code suggestions.
-- @return string?
function AI_openai_code_model()
  return (
    jst.fn.get_secret(vim.g.openai_code_model_env, vim.g.openai_code_model_file)
    or vim.g.openai_code_model
  )
end

--- Returns OpenAI model to use for Agentic AI sessions.
-- @return string?
function AI_openai_agent_model()
  return (
    jst.fn.get_secret(vim.g.openai_agent_model_env, vim.g.openai_agent_model_file)
    or vim.g.openai_agent_model
  )
end

--[[ Agentic ]]

if vim.env.JST_AGENTIC_MODE_PLUGIN then
  vim.g.agentic_mode_plugin = vim.env.JST_AGENTIC_MODE_PLUGIN
end
if not vim.g.agentic_mode_plugin then
  if vim.fn.executable('opencode') == 1 then
    vim.g.agentic_mode_plugin = 'opencode' -- Recommended
  else
    vim.g.agentic_mode_plugin = 'avante'
  end
  -- TODO: vim.g.agentic_mode_plugin = 'codecompanion'
end

--[[ Auto-suggest/Completion ]]

if vim.env.JST_AUTO_SUGGEST_COMPLETION_PLUGIN then
  vim.g.auto_suggest_completion_plugin = vim.env.JST_AUTO_SUGGEST_COMPLETION_PLUGIN
end
if not vim.g.auto_suggest_completion_plugin then
  if AI_is_copilot_active() then
    -- GitHub Copilot is largely the best auto-suggest/completion
    vim.g.auto_suggest_completion_plugin = 'copilot'
  elseif AI_is_ollama_enabled() and vim.g.agentic_mode_plugin == 'avante' then
    -- Reuse same plugin
    vim.g.auto_suggest_completion_plugin = 'avante'
  -- TODO:
  -- elseif vim.g.agentic_mode_plugin == 'codecompanion' then
  --   -- Reuse same plugin
  --   vim.g.auto_suggest_completion_plugin = 'codecompanion'
  elseif AI_is_huggingface_enabled() or AI_is_ollama_enabled() then
    vim.g.auto_suggest_completion_plugin = 'llm'
  end
end

-- vim: sw=2 et
