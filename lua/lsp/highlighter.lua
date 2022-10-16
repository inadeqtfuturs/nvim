local module = {}

function module.setup()
	vim.o.updatetime = 250
	vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(0, {focus=false, scope="cursor", border="rounded"})]])
end

return module
