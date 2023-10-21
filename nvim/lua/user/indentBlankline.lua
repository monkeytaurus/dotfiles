local ibl_status, indentBlankLine = pcall(require, "indent_blankline")

if not ibl_status then
	return
end


 


indentBlankLine.setup({
	show_end = true,
})
