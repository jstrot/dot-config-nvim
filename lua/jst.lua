local M = {
  fn = {},
  _cache = {},
}

local Util = require('lazy.core.util')

local function import_dir(dir)
  local entries = {}
  -- Based on lazy.nvim's Spec:import
  Util.lsmod(dir, function(name, path)
    local entry, _ = loadfile(path)
    if entry then
      entries[name:match("([^.]+)$")] = entry()
    end
  end)
  return entries
end

M.fn.import_dir = import_dir

local function get_secret(varname, filename)
  local value
  value = value or (varname and os.getenv(varname))
  if not value and filename then
    local file = io.open(vim.fn.expand(filename), "r")
    if file then
      value = file:read("*line")
      file:close()
    end
  end
  return value
end

M.fn.get_secret = get_secret

--- Returns the path of an executable in PATH, with options.
local function exepath(name, opts)
  opts = opts or {}
  local path = vim.fn.exepath(name)
  if path ~= '' then
    return path
  end
  if opts.fallback_name then
    return name
  end
  return '' -- As vim.fn.exepath would
end

M.fn.exepath = exepath

local function venv_path()
  if M._cache.venv_path == nil then
    if vim.env.VIRTUAL_ENV then
      M._cache.venv_path = vim.env.VIRTUAL_ENV
    elseif vim.fn.isdirectory('./.venv') == 1 then
      M._cache.venv_path = './.venv'
    elseif vim.fn.isdirectory('./venv') == 1 then
      M._cache.venv_path = './venv'
    else
      M._cache.venv_path = false
    end
  end
  return M._cache.venv_path or nil
end

M.fn.venv_path = venv_path

local function isresolvedpath(path)
  return path and (
    vim.startswith(path, './')
    or vim.fn.isabsolutepath(path) == 1
  )
end

M.fn.isresolvedpath = isresolvedpath

--- Returns the path of an executable within the Python virtual environment.
-- If the executable is not found within the Python virtual environment, it
-- won't be searched in PATH and the empty string ("") is returned (same
-- signtature as vim.fn.exepath).
local function venv_exepath(name, opts)
  opts = opts or {}
  if M.fn.isresolvedpath(name) then
    -- Already an resolved path: just non-venv implementation confirm.
    return M.fn.exepath(name, opts)
  end
  local path
  local venv_path = M.fn.venv_path()
  if venv_path then
    path = vim.fn.exepath(venv_path .. '/bin/' .. name)
    if path ~= '' then
      return path
    end
  end
  if opts.fallback_exepath then
    return M.fn.exepath(name, opts)
  end
  if opts.fallback_name then
    return name
  end
  return '' -- As vim.fn.exepath would
end

M.fn.venv_exepath = venv_exepath

return M
