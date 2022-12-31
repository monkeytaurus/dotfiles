local dap_status, dap = pcall(require, "dap")

if not dap_status then
	return
end
