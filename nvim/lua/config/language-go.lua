require('go').setup({})

require('lspconfig')['gopls'].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
