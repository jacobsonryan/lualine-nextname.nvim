local devicons = require("nvim-web-devicons")

local function capitalize(str)
  return (str:gsub("^%l", string.upper))
end

local function bold(str)
  return "%#StatusLineBold#" .. str .. "%*"
end

return function(opts)
  opts = opts or {}
  local use_brackets = opts.use_brackets == true

  local filepath = vim.api.nvim_buf_get_name(0)
  local filename = vim.fn.fnamemodify(filepath, ":t")
  local ext = vim.fn.fnamemodify(filepath, ":e")
  local icon = devicons.get_icon(filename, ext, { default = true })

  if filename == "page.tsx" or filename == "page.jsx" then
    local folder = vim.fn.fnamemodify(filepath, ":h:t")
    local label = use_brackets
      and string.format("[%s] %s", capitalize(folder), filename)
      or string.format("%s ➜ %s", capitalize(folder), filename)
    return bold(icon .. " " .. label)
  end

  if filename == "route.ts" or filename == "route.js" then
    local normalized = filepath:gsub("\\", "/")
    local api_path = normalized:match("app/api/(.-)/route%.%a+$")
    if api_path then
      local label = use_brackets
        and string.format("[%s] %s", api_path, filename)
        or string.format("%s ➜ %s", api_path, filename)
      return bold(label)
    end
  end

  return bold(icon .. " " .. filename)
end
