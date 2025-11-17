local M = {
  fn = {}
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

return M
