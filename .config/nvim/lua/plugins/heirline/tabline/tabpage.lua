local utils = require("heirline.utils")

local tabPage = {
  provider = function(self)
    return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
  end,
  hl = function(self)
    if not self.is_active then
      return "TabLine"
    else
      return "TabLineSel"
    end
  end,
}

local close = {
  provider = "%999X  %X",
  hl = "TabLine",
}

return {
  -- only show this component if there's 2 or more tabpages
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  { provider = "%=" },
  utils.make_tablist(tabPage),
  close,
}
