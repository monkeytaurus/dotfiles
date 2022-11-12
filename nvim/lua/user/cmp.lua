-- Pcall makes sure NeoVim doesn't break if cmp or luasnip is not installed/loaded 
local has_cmp, cmp = pcall (require, "cmp") 

if not has_cmp then 
	return 
end

local has_luasnip, luasnip = pcall (require, "luasnip") 

if not has_luasnip then 
	return 
end

-- Don't want the snippets to load all at once
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup({
	snippet = {
		-- required - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body) 
		end,
	},
	-- window = {
	-- 	-- completion = cmp.config.window.bordered(),
	-- 	-- documentation = cmp.config.window.bordered(),
	-- },
	mapping = cmp.mapping.preset.insert({
		['<c-k>'] = cmp.mapping.select_prev_item(),
		['<c-j>'] = cmp.mapping.select_next_item(),
		['<c-b>'] = cmp.mapping.scroll_docs(-1),
		['<c-f>'] = cmp.mapping.scroll_docs(1),
		['<c-space>'] = cmp.mapping.complete(),
		['<c-e>'] = cmp.mapping.abort(),
		['<cr>'] = cmp.mapping.confirm({ select = true }), -- accept currently selected item. set `select` to `false` to only confirm explicitly selected items.
		["<tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<s-tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			
	}), 


	sources = { 
		{ name = 'luasnip' },  
		{ name = 'buffer' }, 
		{ name = 'nvim_lsp' }, 
		{ name = 'vsnip' },  
	 { name = 'path' },
	}, 

}) 

-- set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- you can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})

-- use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

