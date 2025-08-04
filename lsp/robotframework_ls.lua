
local capabilities = require('blink.cmp').get_lsp_capabilities()
return {

	cmd = {
		"robotframework_ls",
	},
	filetypes = {
		"robot",
	},
	root_markers = {
		".git",
		"pyproject.toml",
	},
	single_file_support = true,
    capabilities = capabilities,
}
