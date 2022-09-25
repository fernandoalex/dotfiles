local on_attach = function(client, bufnr)
	vim.api.nvim_create_autocmd({"BufWritePre"}, {
		pattern = {"*.tf", "*.tfvars"},
		callback = vim.lsp.buf.formatting_sync,
	})
end

require('lspconfig')['terraformls'].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require('telescope').load_extension('terraform_doc')
