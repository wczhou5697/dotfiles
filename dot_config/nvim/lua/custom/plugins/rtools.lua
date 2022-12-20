local status_ok , rtools = pcall(require , "rust-tools")
if not status_ok then return end

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

rtools.setup({
  server = {
    on_attach = on_attach;
    capabilities = capabilities;
  }
})
