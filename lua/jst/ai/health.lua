-- Call `:checkhealth jst.ai`
require('jst.ai.config')

local M = {}

M.check = function()
  local url_msg
  local api_key_msg
  local health_cmd
  local msg
  local has

  vim.health.start("JST AI Configuration")
  vim.health.info('Configuration file: ' .. vim.fn.stdpath('config') .. ('/lua/config/ai.lua'))
  vim.health.ok("`nvim` version: `" .. tostring(vim.version()) .. "`.")

  vim.health.start("Plugins")
  if vim.g.auto_suggest_completion_plugin then
    health_cmd = 'checkhealth ' .. vim.g.auto_suggest_completion_plugin
    if
      vim.g.auto_suggest_completion_plugin == 'copilot'
      or vim.g.auto_suggest_completion_plugin == 'llm'
    then
      health_cmd = nil
    end
    msg = 'Auto-suggest/completion: ' .. vim.g.auto_suggest_completion_plugin
    if health_cmd then
      msg = msg .. ' (See `' .. health_cmd .. '`)'
    end
    vim.health.ok(msg)
  else
    vim.health.warn('Auto-suggest/completion plugin not set', 'Set `vim.g.auto_suggest_completion_plugin` variable')
  end
  if vim.g.agentic_mode_plugin then
    health_cmd = 'checkhealth ' .. vim.g.agentic_mode_plugin
    vim.health.ok('Agentic mode: ' .. vim.g.agentic_mode_plugin .. ' (See `' .. health_cmd .. '`)')
  else
    vim.health.warn('Agentic mode plugin not set', 'Set `vim.g.agentic_mode_plugin` variable')
  end
  has, _ = pcall(require, 'CopilotChat')
  if has then
    vim.health.ok('Chat: CopilotChat (See `:checkhealth CopilotChat`)')
  else
    vim.health.warn('Chat: CopilotChat not enabled', 'Available when Copilot is enabled.')
  end
  has, _ = pcall(require, 'ogpt')
  if has then
    vim.health.ok('Chat: OGPT')
  else
    vim.health.warn('Chat: OGPT not enabled', 'Available when one of Ollama, OpenAI, or Hugging Face is enabled.')
  end
  has, _ = pcall(require, 'chatgpt')
  if has then
    vim.health.ok('Chat: ChatGPT')
  else
    vim.health.warn('Chat: ChatGPT not enabled', 'Available when OpenAI is enabled.')
  end

  vim.health.start("Copilot")
  if AI_is_copilot_enabled() then
    vim.health.ok("Enabled")
    if AI_is_copilot_active() then
      vim.health.ok("Active")
    else
      vim.health.warn("Not active", "Activate with `vim.g.github_copilot_active = true`")
    end
    if AI_copilot_chat_model() then
      vim.health.ok("Chat model:  " .. AI_copilot_chat_model())
    else
      vim.health.warn("Chat model not set (Optional).", "Set with `vim.g.copilot_chat_model` variable.")
    end
    if AI_copilot_code_model() then
      vim.health.ok("Code model:  " .. AI_copilot_code_model())
    else
      vim.health.warn("Code model not set (Optional).", "Set with `vim.g.copilot_code_model` variable.")
    end
    if AI_copilot_agent_model() then
      vim.health.ok("Agent model: " .. AI_copilot_agent_model())
    else
      vim.health.warn("Agent model not set (Optional).", "Set with `vim.g.copilot_agent_model` variable.")
    end
  else
    vim.health.info("Not enabled -> Set `vim.g.github_copilot_enabled = true`")
  end

  vim.health.start("Ollama")
  url_msg = "Set URL with `" .. vim.inspect(vim.g.ollama_url_env) .. "` environment or `" .. vim.inspect(vim.g.ollama_url_file) .. "` file."
  api_key_msg = "Set API key with `" .. vim.inspect(vim.g.ollama_token_env) .. "` environment or `" .. vim.inspect(vim.g.ollama_token_file) .. "` file."
  if AI_is_ollama_enabled() then
    vim.health.ok("Enabled")
    if AI_ollama_url() then
      vim.health.ok("URL: " .. AI_ollama_url())
    else
      vim.health.error("URL not set", url_msg)
    end
    if AI_ollama_api_key() then
      vim.health.ok("API key set.")
    else
      vim.health.warn("API key not set (Optional).", api_key_msg)
    end
    if AI_ollama_chat_model() then
      vim.health.ok("Chat model:  " .. AI_ollama_chat_model())
    else
      vim.health.warn("Chat model not set.", "Set with `" .. vim.inspect(vim.g.ollama_chat_model_env) .. "` environment, or `" .. vim.inspect(vim.g.ollama_chat_model_file) .. "` file, or `vim.g.ollama_chat_model` variable.")
    end
    if AI_ollama_code_model() then
      vim.health.ok("Code model:  " .. AI_ollama_code_model())
    else
      vim.health.warn("Code model not set.", "Set with `" .. vim.inspect(vim.g.ollama_code_model_env) .. "` environment, or `" .. vim.inspect(vim.g.ollama_code_model_file) .. "` file, or `vim.g.ollama_code_model` variable.")
    end
    if AI_ollama_agent_model() then
      vim.health.ok("Agent model: " .. AI_ollama_agent_model())
    else
      vim.health.warn("Agent model not set.", "Set with `" .. vim.inspect(vim.g.ollama_agent_model_env) .. "` environment, or `" .. vim.inspect(vim.g.ollama_agent_model_file) .. "` file, or `vim.g.ollama_agent_model` variable.")
    end
  else
    vim.health.info("Not enabled. " .. url_msg)
  end

  vim.health.start("Hugging Face")
  url_msg = "Set URL with `" .. vim.inspect(vim.g.huggingface_url_env) .. "` environment or `" .. vim.inspect(vim.g.huggingface_url_file) .. "` file."
  api_key_msg = "Set API key with `\"HF_HOME\"` environment, `" .. vim.inspect(vim.g.huggingface_token_env) .. "` environment or `" .. vim.inspect(vim.g.huggingface_token_file) .. "` file."
  if AI_is_huggingface_enabled() then
    vim.health.ok("Enabled")
  else
    vim.health.info("Not enabled. " .. api_key_msg)
  end
  if vim.env.HF_HOME then
    vim.health.ok("`\"HF_HOME\"` environment: " .. vim.env.HF_HOME)
  else
    vim.health.info("`\"HF_HOME\"` environment not set.")
  end
  if AI_is_huggingface_enabled() then
    if AI_huggingface_url() then
      vim.health.ok("URL: " .. AI_huggingface_url())
    else
      vim.health.warn("URL not set (Optional).", url_msg)
    end
    if AI_huggingface_api_key() then
      vim.health.ok("API key set.")
    else
      vim.health.error("API key not set.", api_key_msg)
    end
    if AI_huggingface_chat_model() then
      vim.health.ok("Chat model:  " .. AI_huggingface_chat_model())
    else
      vim.health.warn("Chat model not set.", "Set with `" .. vim.inspect(vim.g.huggingface_chat_model_env) .. "` environment, or `" .. vim.inspect(vim.g.huggingface_chat_model_file) .. "` file, or `vim.g.huggingface_chat_model` variable.")
    end
    if AI_huggingface_code_model() then
      vim.health.ok("Code model:  " .. AI_huggingface_code_model())
    else
      vim.health.warn("Code model not set.", "Set with `" .. vim.inspect(vim.g.huggingface_code_model_env) .. "` environment, or `" .. vim.inspect(vim.g.huggingface_code_model_file) .. "` file, or `vim.g.huggingface_code_model` variable.")
    end
    if AI_huggingface_agent_model() then
      vim.health.ok("Agent model: " .. AI_huggingface_agent_model())
    else
      vim.health.warn("Agent model not set.", "Set with `" .. vim.inspect(vim.g.huggingface_agent_model_env) .. "` environment, or `" .. vim.inspect(vim.g.huggingface_agent_model_file) .. "` file, or `vim.g.huggingface_agent_model` variable.")
    end
  end

  vim.health.start("OpenAI")
  url_msg = "Set URL with `" .. vim.inspect(vim.g.openai_url_env) .. "` environment or `" .. vim.inspect(vim.g.openai_url_file) .. "` file."
  api_key_msg = "Set API key with `" .. vim.inspect(vim.g.openai_token_env) .. "` environment or `" .. vim.inspect(vim.g.openai_token_file) .. "` file."
  if AI_is_openai_enabled() then
    vim.health.ok("Enabled")
    if AI_openai_url() then
      vim.health.ok("URL: " .. AI_openai_url())
      vim.health.ok("URL w/ version: " .. AI_openai_ver_url())
      vim.health.ok("URL w/o version: " .. AI_openai_nover_url())
    else
      vim.health.warn("URL not set (Optional).", url_msg)
    end
    if AI_openai_api_key() then
      vim.health.ok("API key set")
    else
      vim.health.error("API key not set.", api_key_msg)
    end
    if AI_openai_chat_model() then
      vim.health.ok("Chat model:  " .. AI_openai_chat_model())
    else
      vim.health.warn("Chat model not set.", "Set with `" .. vim.inspect(vim.g.openai_chat_model_env) .. "` environment, or `" .. vim.inspect(vim.g.openai_chat_model_file) .. "` file, or `vim.g.openai_chat_model` variable.")
    end
    if AI_openai_code_model() then
      vim.health.ok("Code model:  " .. AI_openai_code_model())
    else
      vim.health.warn("Code model not set.", "Set with `" .. vim.inspect(vim.g.openai_code_model_env) .. "` environment, or `" .. vim.inspect(vim.g.openai_code_model_file) .. "` file, or `vim.g.openai_code_model` variable.")
    end
    if AI_openai_agent_model() then
      vim.health.ok("Agent model: " .. AI_openai_agent_model())
    else
      -- TODO: vim.health.warn("Agent model not set.", "Set with `" .. vim.inspect(vim.g.openai_agent_model_env) .. "` environment, or `" .. vim.inspect(vim.g.openai_agent_model_file) .. "` file, or `vim.g.openai_agent_model` variable.")
    end
  else
    vim.health.info("Not enabled. " .. url_msg)
  end

  vim.health.start("Opencode")
  local opencode_path = vim.fn.exepath('opencode')
  if opencode_path ~= '' then
    vim.health.ok("Opencode CLI found: " .. opencode_path)
  else
    vim.health.error("Opencode CLI not found in PATH.", "Install from https://opencode.ai/")
  end
end

return M

-- vim: sw=2 et
