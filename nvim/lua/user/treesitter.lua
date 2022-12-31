local treesiter_ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not treesiter_ok then
	return
end

treesitter.setup({
	highlight = {
		enable = true, -- `false` will disable the whole extension
	},

	indent = {
		enable = true,
	},

	autotag = {
		enable = true,
		filetypes = { "html", "tsx" },
	},

	ensure_installed = {
		"c",
		"lua",
		"rust",
		"html",
		"css",
		"javascript",
		"typescript",
		"json",
		"lua",
		"svelte",
		"vue",
		"tsx",
		"php",
		"markdown",
		"glimmer",
		"scss",
		"python",
		"cpp",
	},
	auto_install = true,

	context_commentstring = {
		enable = true,
		config = {
			javascript = {
				__default = "// %s",
				__multiline = "/* %s */",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = { __default = "// %s", __multiline = "/* %s */" },
				comment = { __default = "// %s", __multiline = "/* %s */" },
				call_expression = { __default = "// %s", __multiline = "/* %s */" },
				statement_block = { __default = "// %s", __multiline = "/* %s */" },
				spread_element = { __default = "// %s", __multiline = "/* %s */" },
			},
			typescript = {
				__default = "// %s",
				__multiline = "/* %s */",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = { __default = "// %s", __multiline = "/* %s */" },
				comment = { __default = "// %s", __multiline = "/* %s */" },
				call_expression = { __default = "// %s", __multiline = "/* %s */" },
				statement_block = { __default = "// %s", __multiline = "/* %s */" },
				spread_element = { __default = "// %s", __multiline = "/* %s */" },
			},
		},
	},
})
