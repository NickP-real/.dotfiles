local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local illuminate_status_ok, illuminate = pcall(require, "illuminate")
if not (cmp_nvim_lsp_status_ok and illuminate_status_ok) then
  return
end

local M = {}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
M.diagnostic_signs = signs

local diagnostic_config = {
  update_in_insert = false,
  virtual_text = true,
  signs = { active = signs },
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
  },
}

M.diagnostic_config = diagnostic_config

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_config),
}

local no_diagnositc_handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
  ["textDocument/publishDiagnostics"] = function() end,
}

M.handlers = handlers
M.no_diagnostic_handler = no_diagnositc_handlers

local auto_format = function(bufnr)
  local group = vim.api.nvim_create_augroup("LSP Format", { clear = false })
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.formatting_sync()
    end,
    group = group,
  })
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float({border = 'rounded'})<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({border = 'rounded'})<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({border = 'rounded'})<CR>", opts)
  buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

  if client.resolved_capabilities.document_formatting then
    auto_format(bufnr)
  end

  if client.resolved_capabilities.document_highlight then
    illuminate.on_attach(client)
  end
end

M.auto_format = auto_format

M.on_attach = on_attach

M.custom_diagnostic_hide = function(bufnr)
  local diag_group = vim.api.nvim_create_augroup("null-ls diagnostics", { clear = false })
  vim.api.nvim_create_autocmd("InsertCharPre", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.hide(nil, bufnr)
    end,
    group = diag_group,
  })
  vim.api.nvim_create_autocmd("InsertLeavePre", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.show(nil, bufnr)
    end,
    group = diag_group,
  })
end

M.no_format_on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

M.flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 150,
}

return M
