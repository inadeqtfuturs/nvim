module = {}

function module.init(use)
	local config = {
		"substrata",
		"bufferline",
		"lualine",
		--[[ "nvimtree", ]]
		"neotree",
	}

	initialize(use, "ui", config)
end

return module
