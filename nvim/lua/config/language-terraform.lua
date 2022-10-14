require('lspconfig')['terraformls'].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require('telescope').load_extension('terraform_doc')
