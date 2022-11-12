--require("mason").setup() 

local mason_ok, mason = pcall (require, "mason")  

if not mason_ok then 
	return 
end 

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}) 


require("mason-lspconfig").setup()

local mason_lspconfig_status, mason_lspconfig = pcall (require, "mason-lspconfig") 

if not mason_lspconfig_status then
	return 
end 

mason_lspconfig.setup({
	ensure_installed = { 
		"sumneko_lua", 
		"rust_analyzer",
		"cssls",
		"emmet_ls",
		"html",
		"pyright", 
		"tsserver",
	 }

}) 


local mason_null_ls_status, mason_null_ls = pcall (require, "mason-null-ls")

if not mason_null_ls_status then 
	return 
end  

mason_null_ls.setup({ 

 ensure_installed = {  
		"stylua", 
		"prettier", 
		"eslint",
		"gitsigns", 
		"eslint_d", 
		"write_good", 

		 
	}
})



