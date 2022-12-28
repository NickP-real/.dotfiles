local M = {}

M.strsplit = function(inputstr)
  local t = {}
  for str in string.gmatch(inputstr, "([^%s]+)") do
    table.insert(t, str)
  end
  return t
end

M.notify = function(text, title)
  vim.notify(text, nil, { title = title })
end

return M
