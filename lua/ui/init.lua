module = {}

function module.init(use)
	local config = {
		"substrata",
		-- "oxocarbon",
		"bufferline",
		-- "heirline",
		"lualine",
		"neotree",
	}

	initialize(use, "ui", config)
end

return module
