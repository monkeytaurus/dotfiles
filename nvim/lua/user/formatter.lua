local conform_ok, conform = pcall(require, "conform")

if not conform_ok then
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua", "black" },
		java = { "google-java-format" },
		javascript = { "prettier" },
		css = { "stylelint", "prettier" },
		pythonf = { "isort", "black" },
		c = { "clang-format" },
	},

	formatters = {
		clang_format = {
			command = "clang-format",
			args = { "--style={BasedOnStyle: Google, IndentWidth: 4}" },
		},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end)
