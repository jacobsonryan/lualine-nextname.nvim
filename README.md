# lualine-nextname.nvim

🎯 A custom [Lualine](https://github.com/nvim-lualine/lualine.nvim) component that prettifies filenames — especially for [Next.js](https://nextjs.org/) projects.

It shows intelligent labels for files like `page.tsx` and `route.ts`, turning this:

```txt
page.tsx → Home ➜ page.tsx
route.ts → /api/user
```
---

## ✨ Features

- Adds icons using `nvim-web-devicons`
- Capitalizes parent folders for `page.tsx` / `page.jsx`
- Converts `app/api/**/route.ts` to clean API route paths
- Styled with a bold highlight group (`StatusLineBold`)

---

## 📦 Installation

This plugin is meant to be used **as a dependency of `nvim-lualine/lualine.nvim`**, not as a standalone plugin.

✅ Just add it to your Lualine plugin's `dependencies` section.

### Lazy.nvim Example

```lua
{
  "nvim-lualine/lualine.nvim",
  dependencies = {
     "nvim-tree/nvim-web-devicons",
    "jacobsonryan/lualine-nextname.nvim", -- ✅ Add it here
  },
  config = function()
    local nextname = require("lualine_components.nextname")

    require("lualine").setup({
      sections = {
        lualine_c = { nextname },
        -- other sections...
      },
    })

    -- Optional: add highlight group for bold display
    vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true, fg = "#ffffff", bg = "NONE" })
  end,
}
