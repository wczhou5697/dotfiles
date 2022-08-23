local user_plugin_opts = astronvim.user_plugin_opts
local conditional_func = astronvim.conditional_func

-- vim.api.nvim_set_keymap()

lsp.on_attach = function(client, bufnr)
-- ["K"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
-- ["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" },
-- ["<leader>lf"] = { function() vim.lsp.buf.formatting_sync() end, desc = "Format code" },
-- ["<leader>lh"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" },
-- ["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "Rename current symbol" },
-- ["gD"] = { function() vim.lsp.buf.declaration() end, desc = "Declaration of current symbol" },
-- ["gI"] = { function() vim.lsp.buf.implementation() end, desc = "Implementation of current symbol" },
-- ["gd"] = { function() vim.lsp.buf.definition() end, desc = "Show the definition of current symbol" },
-- ["gr"] = { function() vim.lsp.buf.references() end, desc = "References of current symbol" },
-- ["<leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
-- ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
-- ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
-- ["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
-- { buffer = bufnr }

    vim.api.nvim_set_keymap("n", "K", function() vim.lsp.buf.hover() end, { buffer = bufnr , desc = "Hover symbol details" })
    vim.api.nvim_set_keymap("n", "<leader>la", function() vim.lsp.buf.code_action() end, { buffer = bufnr , desc = "LSP code action" })
    vim.api.nvim_set_keymap("n", "<leader>lf", function() vim.lsp.buf.formatting_sync() end, { buffer = bufnr , desc = "Format code" })
    vim.api.nvim_set_keymap("n", "<leader>lh", function() vim.lsp.buf.signature_help() end, { buffer = bufnr , desc = "Signature help" })
    vim.api.nvim_set_keymap("n", "<leader>lr", function() vim.lsp.buf.rename() end, { buffer = bufnr , desc = "Rename current symbol" })
    vim.api.nvim_set_keymap("n", "gD", function() vim.lsp.buf.declaration() end, { buffer = bufnr , desc = "Declaration of current symbol" })
    vim.api.nvim_set_keymap("n", "gI", function() vim.lsp.buf.implementation() end, { buffer = bufnr , desc = "Implementation of current symbol" })
    vim.api.nvim_set_keymap("n", "gd", function() vim.lsp.buf.definition() end, { buffer = bufnr , desc = "Show the definition of current symbol" })
    vim.api.nvim_set_keymap("n", "gr", function() vim.lsp.buf.references() end, { buffer = bufnr , desc = "References of current symbol" })
    vim.api.nvim_set_keymap("n", "<leader>ld", function() vim.diagnostic.open_float() end, { buffer = bufnr , desc = "Hover diagnostics" })
    vim.api.nvim_set_keymap("n", "[d", function() vim.diagnostic.goto_prev() end, { buffer = bufnr , desc = "Previous diagnostic" })
    vim.api.nvim_set_keymap("n", "]d", function() vim.diagnostic.goto_next() end, { buffer = bufnr , desc = "Next diagnostic" })
    vim.api.nvim_set_keymap("n", "gl", function() vim.diagnostic.open_float() end, { buffer = bufnr , desc = "Hover diagnostics" })

    vim.api.nvim_buf_create_user_command(
        bufnr,
        "Format",
        function() vim.lsp.buf.formatting() end,
        { desc = "Format file with LSP" }
    )
    
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "lsp_document_highlight",
            pattern = "<buffer>",
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            pattern = "<buffer>",
            callback = vim.lsp.buf.clear_references,
        })
    end
 
    local aerial_avail, aerial = pcall(require, "aerial")
    conditional_func(aerial.on_attach, aerial_avail, client, bufnr)
end

astronvim.lsp.capabilities = vim.lsp.protocol.make_client_capabilities()
astronvim.lsp.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
astronvim.lsp.capabilities.textDocument.completion.completionItem.snippetSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.preselectSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
astronvim.lsp.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
astronvim.lsp.capabilities = user_plugin_opts("lsp.capabilities", astronvim.lsp.capabilities)
astronvim.lsp.flags = user_plugin_opts "lsp.flags"

function astronvim.lsp.server_settings(server_name)
  local server = require("lspconfig")[server_name]
  local opts = user_plugin_opts(
    "lsp.server-settings." .. server_name,
    user_plugin_opts("lsp.server-settings." .. server_name, {
      capabilities = vim.tbl_deep_extend("force", astronvim.lsp.capabilities, server.capabilities or {}),
      flags = vim.tbl_deep_extend("force", astronvim.lsp.flags, server.flags or {}),
    }, true, "configs")
  )
  local old_on_attach = server.on_attach
  local user_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    conditional_func(old_on_attach, true, client, bufnr)
    astronvim.lsp.on_attach(client, bufnr)
    conditional_func(user_on_attach, true, client, bufnr)
  end
  return opts
end

function astronvim.lsp.disable_formatting(client) client.resolved_capabilities.document_formatting = false end

return astronvim.lsp
