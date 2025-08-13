
local capabilities = require('blink.cmp').get_lsp_capabilities()
return {

	cmd = {
		"C:\\Users\\K858102\\AppData\\Local\\mise\\installs\\python\\3.13.2\\Scripts\\robotframework_ls",
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
