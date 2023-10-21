-- local ibl_status, indentBlankLine = pcall(require, "indent_blankline")
--
-- if not ibl_status then
-- 	return
-- end

local highlight = {
	"CursorColumn",
	"Whitespace",
}
require ("ibl").setup({
	indent = { highlight = highlight, char = "" },
	whitespace = {
		highlight = highlight,
		remove_blankline_trail = false,
	},
	scope = { enabled = false },
})
