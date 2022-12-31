local null_ok, null_ls = pcall(require, "null-ls")

if not null_ok then
	return
end

local code_actions = null_ls.builtins.code_actions

local diagnostics = null_ls.builtins.diagnostics

local formatting = null_ls.builtins.formatting

-- local hover = null_ls.builtins.hover

local completion = null_ls.builtins.completion

null_ls.setup({
	sources = {
		formatting.stylua,
		formatting.prettier,
		formatting.prettierd,
		-- code_actions.eslint,
		code_actions.eslint_d,
		diagnostics.eslint,
		diagnostics.write_good,
		completion.spell,
	},
	debug = true,
})
