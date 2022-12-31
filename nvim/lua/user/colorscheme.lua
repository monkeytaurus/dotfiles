local colorscheme = "tokyonight-storm"
local status_color, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_color then
	vim.notify("colorscheme" .. colorscheme .. "not found")
	return
end
