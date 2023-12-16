-- helper for keymapping in plugin configs
function _G.map(mode, combo, mapping, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

function _G.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- used for initializing plugin folders
function _G.initialize(use, namespace, config)
	if config ~= nil then
		for _, name in ipairs(config) do
			require(namespace .. "/" .. name).init(use)
		end
	end
end
