local devicons = require("nvim-web-devicons")

local function capitalize(str)
  return (str:gsub("^%l", string.upper))
end

local function bold(str)
  return "%#StatusLineBold#" .. str .. "%*"
end

return function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath == "" then
    return ""
  end

  local filename = vim.fn.fnamemodify(filepath, ":t")
  local ext = vim.fn.fnamemodify(filepath, ":e")
  local icon = devicons.get_icon(filename, ext, { default = true })

  local folder = capitalize(vim.fn.fnamemodify(filepath, ":h:t"))

  -- Handle Next.js special files like page, layout, template (any .js/.ts/.jsx/.tsx)
  if filename:match("^(page|layout|template)%.%a+$") then
    return bold(icon .. " " .. folder .. " ➜ " .. filename)
  end

  -- Handle API routes (Next.js)
  if filename == "route.ts" or filename == "route.js" then
    local normalized = filepath:gsub("\\", "/")
    local api_path = normalized:match("app/(api/.-)/route%.%a+$")
    if api_path then
      return bold(icon .. " " .. api_path .. " ➜ " .. filename)
    end
  end

  -- Default fallback
  return bold(icon .. " " .. filename)
end
