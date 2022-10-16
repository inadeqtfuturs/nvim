module = {}

function module.init(use)
	local config = {
		"gitsigns",
		"diffview",
		"blamer",
	}

	initialize(use, "git", config)
end

return module
