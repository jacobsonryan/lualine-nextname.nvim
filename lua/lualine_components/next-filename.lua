local M = {}

local devicons = require("nvim-web-devicons")

local function capitalize(str)
  return (str:gsub("^%l", string.upper))
end

local function bold(str)
  return "%#StatusLineBold#" .. str .. "%*"
end

M.get = function()
  local filepath = vim.api.nvim_buf_get_name(0)
  local filename = vim.fn.fnamemodify(filepath, ":t")
  local ext = vim.fn.fnamemodify(filepath, ":e")
  local icon = devicons.get_icon(filename, ext, { default = true })

  if filename == "page.tsx" or filename == "page.jsx" then
    local folder = vim.fn.fnamemodify(filepath, ":h:t")
    return bold(icon .. " " .. capitalize(folder) .. " ➜ " .. filename)
  end

  if filename == "route.ts" or filename == "route.js" then
    local normalized = filepath:gsub("\\", "/")
    local api_path = normalized:match("app/api/(.-)/route%.%a+$")
    return bold("/api/" .. (api_path or ""))
  end

  return bold(icon .. " " .. filename)
end

return M
