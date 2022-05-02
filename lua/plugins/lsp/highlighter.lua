local module = {}

function module.setup(client)
	vim.o.updatetime = 250
	vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(0, {focus=false, scope="cursor", border="rounded"})]])

	if false then
		local present, illuminate = pcall(require, "illuminate")
		if present then
			illuminate.on_attach(client)
		end
	end
end

return module
