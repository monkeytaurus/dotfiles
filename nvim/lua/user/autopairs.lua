local nvim_autopair_ok,  npair = pcall (require, "nvim-autopairs") 

if not nvim_autopair_ok then 
	return 
end

local autopair_cmp_setup, cmp_autopairs = pcall (require, 'nvim-autopairs.completion.cmp')
 
if not autopair_cmp_setup then 
	return
end 


local cmp_status, cmp = pcall (require,'cmp') 

if not cmp_status then  
	return
end

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
) 

	
npair.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

