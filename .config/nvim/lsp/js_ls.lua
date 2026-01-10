return {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "js" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	settings = {
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
			suggest = { completeFunctionCalls = true },
		},
		javascript = {
			updateImportsOnFileMove = { enabled = "always" },
			suggest = { completeFunctionCalls = true },
			implicitProjectConfig = { checkJs = true },
		},
		vtsls = {
			autoUseWorkspaceTsdk = true,
			experimental = {
				completion = { enableServerSideFuzzyMatch = true },
			},
		},
	},
}
