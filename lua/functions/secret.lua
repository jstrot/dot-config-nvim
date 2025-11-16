function jst_get_secret(varname, filename)
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

