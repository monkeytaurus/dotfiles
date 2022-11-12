local null_ok, null_ls = pcall(require, "null-ls")

if null_ok then
	return
end


local code_actions = null_ls.builtins.code_actions

local diagnostics = null_ls.builtins.diagnostics

local formatting = null_ls.builtins.formatting

-- local hover = null_ls.builtins.hover

local completion = null_ls.builtins.completion


local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		formatting.stylua,
		formatting.prettier,
		code_actions.eslint,
		code_actions.gitsigns,
		diagnostics.eslint,
		diagnostics.write_good,
		completion.spell,

		-- Format on Save
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
						-- vim.lsp.buf.formatting_sync()
					end,
				})
			end
		end,
	},

})
