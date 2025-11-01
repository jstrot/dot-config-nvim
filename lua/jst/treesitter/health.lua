-- Call `:checkhealth jst.treesitter`
local jst_ts = require('jst.treesitter.config')

local M = {}

M.check = function()
  local url_msg
  local api_key_msg
  local health_cmd
  local msg
  local has

  vim.health.start("JST Tree-sitter Configuration")
  vim.health.ok("`nvim` version: `" .. tostring(vim.version()) .. "`.")
  -- vim.health.info("API used: " .. jst_ts.api_used)

  vim.health.start("Configuration")
  if jst_ts.ts_enabled then
    vim.health.ok("Tree-sitter configuration is enabled.")
  else
    vim.health.warn("Tree-sitter configuration is DISABLED.")
  end

  vim.health.start("Plugins")
  for _, plugin in pairs({
    'nvim-treesitter',
    'ts-install',
  }) do
    if package.loaded[plugin] then
      vim.health.ok(plugin .. " is loaded.")
    else
      vim.health.warn(plugin .. " is NOT loaded.")
    end
  end

  vim.health.start("See also")
  vim.health.info("`:checkhealth vim.treesitter`")
  vim.health.info("`:checkhealth nvim-treesitter`")

  -- Like nvim-treesitter but about *all* vim.treesitter parsers
  vim.health.start(string.format("%-26s %s", "Installed parsers", "H L F I J"))
  local bundled_queries = { 'highlights', 'locals', 'folds', 'indents', 'injections' }
  local legend = 'Legend: H[ighlights], L[ocals], F[olds], I[ndents], In[J]ections'

  local parsers1 = {}
  for parser, _ in pairs(jst_ts.get_installed()) do
    table.insert(parsers1, parser)
  end
  table.sort(parsers1)
  jst_ts.update_parser_cache() -- Important!
  local parsers = {}
  for parser, _ in pairs(jst_ts.get_installed()) do
    table.insert(parsers, parser)
  end
  table.sort(parsers)
  if table.concat(parsers1) ~= table.concat(parsers) then
    vim.health.warn("Parser cache was out of date, refreshed.")
  end

  local function query_status(lang, query_group)
    -- local ok, err = pcall(tsq.get, lang, query_group)
    local ok, err = pcall(jst_ts.have_query, lang, query_group)
    if not ok then
      return 'x', err
    elseif not err then
      return '.'
    else
      return '✓'
    end
  end

  for _, parser in ipairs(parsers) do
    local queries = {}
    for _, query_group in pairs(bundled_queries) do
      local status, err = query_status(parser, query_group)
      queries[#queries + 1] = status
      if status == 'x' then
        vim.health.error(
          string.format("Parser '%s' query '%s' error: %s", parser, query_group, err)
        )
      end
    end
    vim.health.info(string.format("%-24s %s", parser, table.concat(queries, " ")))
  end
  vim.health.start('  ' .. legend)

end

return M
