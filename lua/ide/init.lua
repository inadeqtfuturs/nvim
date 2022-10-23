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
		"todo",
	}

	initialize(use, "ide", config)
end

return module
