local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
local function footer()
  local version = vim.version()
  local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
  return nvim_version_info
end

dashboard.section.header.val = {
  [[      ___           ___           ___           ___                       ___     ]],
  [[     /\__\         /\  \         /\  \         /\__\          ___        /\__\    ]],
  [[    /::|  |       /::\  \       /::\  \       /:/  /         /\  \      /::|  |   ]],
  [[   /:|:|  |      /:/\:\  \     /:/\:\  \     /:/  /          \:\  \    /:|:|  |   ]],
  [[  /:/|:|  |__   /::\~\:\  \   /:/  \:\  \   /:/__/  ___      /::\__\  /:/|:|__|__ ]],
  [[ /:/ |:| /\__\ /:/\:\ \:\__\ /:/__/ \:\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\]],
  [[ \/__|:|/:/  / \:\~\:\ \/__/ \:\  \ /:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  /]],
  [[     |:/:/  /   \:\ \:\__\    \:\  /:/  /   |:|__/:/  /  \::/__/           /:/  / ]],
  [[     |::/  /     \:\ \/__/     \:\/:/  /     \::::/__/    \:\__\          /:/  /  ]],
  [[     /:/  /       \:\__\        \::/  /       ~~~~         \/__/         /:/  /   ]],
  [[     \/__/         \/__/         \/__/                                   \/__/    ]],
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  New File", "<cmd>ene <CR>"),
  dashboard.button("SPC f f", "  Find File"),
  dashboard.button("SPC f b", "  File Browser"),
  dashboard.button("SPC f o", "  Recently Opened Files"),
  -- dashboard.button("SPC f r", "  Frecency/MRU"),
  dashboard.button("SPC f g", "  Find Word"),
  -- dashboard.button("SPC f m", "  Jump to Bookmarks"),
  dashboard.button("SPC s l", "  Open Last Session"),
  dashboard.button("v", "  Neovim Config", "<cmd>e ~/.config/nvim/init.lua<CR>"),
  -- dashboard.button("p", "  Plugin Config", "<cmd>e ~/.config/nvim/after/plugin/<CR>"),
  -- dashboard.button("t", "  Theme Config", "<cmd>e ~/.config/nvim/plugin/theme.lua<CR>"),
  dashboard.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
}

dashboard.section.footer.val = footer()

alpha.setup(dashboard.opts)
