-- rust-tools already configures the lsp for rust so don't setup that
require("rust-tools").setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
