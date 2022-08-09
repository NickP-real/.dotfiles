local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
  ----------------
  -- Formatting --
  ----------------

  -- lua
  formatting.stylua,

  -- python
  formatting.black.with({ extra_args = { "--fast" } }),

  -- front-end
  formatting.prettierd,
  formatting.rustywind.with({
    condition = function(utils)
      return utils.root_has_file({ "tailwind.config.js", "tailwind.config.ts" })
    end,
  }),

  -- go
  formatting.golines,

  ----------------
  -- Diagnostic --
  ----------------

  -- front-end
  diagnostics.eslint_d.with({
    condition = function(utils)
      return utils.root_has_file({ ".eslintrc.json" })
    end,
  }),

  ------------------
  -- Code Actions --
  ------------------

  -- front-end
  code_actions.eslint_d.with({
    condition = function(utils)
      return utils.root_has_file({ ".eslintrc.json" })
    end,
  }),
}

local utils = require("lsp.utils")

null_ls.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      utils.auto_format(client)
    end
  end,
  update_in_insert = false,
  debounce = 150,
})
