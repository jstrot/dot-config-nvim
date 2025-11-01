local M = {}

local Util = require('lazy.core.util')

function jst_import_dir(dir)
  local entries = {}
  -- Based on lazy.nvim's Spec:import
  Util.lsmod(dir, function(name, path)
    local entry, err = loadfile(path)
    if entry then
      entries[name:match("([^.]+)$")] = entry()
    end
  end)
  return entries
end

M.import_dir = jst_import_dir

return M
