local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Makes sure neovim still works if packer is not here
local status_packer, packer = pcall(require, "packer")
if not status_packer then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")

	--Nvim-tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly",              -- optional, updated every week. (see issue #1193)
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	-- Indent Lines
	use("lukas-reineke/indent-blankline.nvim")

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({ "windwp/nvim-ts-autotag" })

	-- Themes
	use("EdenEast/nightfox.nvim")
	use("folke/tokyonight.nvim")

	-- CMP
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	--Comment
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Installing LSP Servers
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- DAP
	use("mfussenegger/nvim-dap")

	-- LSP
	use("neovim/nvim-lspconfig") -- Configurations for Nvim LSP
	use("hrsh7th/cmp-nvim-lsp")
	use("jose-elias-alvarez/typescript.nvim")
	use("glepnir/lspsaga.nvim")
	use("mfussenegger/nvim-jdtls")

	-- formatting and linting
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	-- tmux
	use("christoomey/vim-tmux-navigator")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins

	-- Undotree
	use("mbbill/undotree")
	--
	-- SML
	use("jez/vim-better-sml")

	-- Vim Buffer Maximizer
	use("szw/vim-maximizer")



	if packer_bootstrap then
		require("packer").sync()
	end
end)
