-- require('config.treesitter')

local M = {}

M.ts_enabled = vim.fn.has('nvim-0.10') == 1

--[[ API inspired by LazyVim's treesitter utils: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/treesitter.lua ]]
-- local M = {} -- a.k.a., LazyVim.treesitter
M._installed = nil ---@type table<string,boolean>?
M._queries = {} ---@type table<string,boolean>

if vim.fn.has('nvim-0.11.0') == 1 then
  M.api_used = 'vim.treesitter'

  function M.update_parser_cache()
    -- New nvim.treesitter API
    M._installed, M._queries = {}, {}
    -- Based on share/nvim/runtime/lua/vim/treesitter/health.lua
    local parsers = vim.api.nvim_get_runtime_file('parser/*', true)
    for i, parser_path in ipairs(parsers) do
      local parser = vim.fn.fnamemodify(parser_path, ':t:r')
      M._installed[parser] = true
    end
  end

else
  M.api_used = 'nvim-treesitter'

  function M.update_parser_cache()
    -- Rely on nvim-treesitter API
    M._installed, M._queries = {}, {}
    for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
      M._installed[lang] = true
    end
  end

end

---@param update boolean?
function M.get_installed(update)
  if update or not M._installed then
    M.update_parser_cache()
  end
  return M._installed or {}
end

---@param lang string
---@param query string
function M.have_query(lang, query)
  local key = lang .. ":" .. query
  if M._queries[key] == nil then
    M._queries[key] = vim.treesitter.query.get(lang, query) ~= nil
  end
  return M._queries[key]
end

---@param what string|number|nil
---@param query? string
---@overload fun(buf?:number):boolean
---@overload fun(ft:string):boolean
---@return boolean
function M.have(what, query)
  what = what or vim.api.nvim_get_current_buf()
  what = type(what) == "number" and vim.bo[what].filetype or what --[[@as string]]
  local lang = vim.treesitter.language.get_lang(what)
  if lang == nil or M.get_installed()[lang] == nil then
    return false
  end
  if query and not M.have_query(lang, query) then
    return false
  end
  return true
end

return M
