module = {}

function module.init(use)
	local config = {
		"autopairs",
		"autotag",
		"comments",
		"indent_blankline",
		"lightspeed",
		"surround",
		"telescope",
		"toggleterm",
		"treesitter",
	}

	initialize(use, "ide", config)
end

return module
