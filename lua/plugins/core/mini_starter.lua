local module = {
	"echasnovski/mini.nvim",
	priority = 1001,
	event = "VimEnter",

	config = function()
		local starter = require("mini.starter")
		starter.setup({
			header = "Feelin' fine...",
			footer = "",
			items = {
				{ section = "quick actions", name = "find file", action = "Telescope find_files" },
				{ section = "quick actions", name = "find word", action = "Telescope live grep" },
				function()
					local section = "recent files"
					local files = vim.tbl_filter(function(f)
						return vim.fn.filereadable(f) == 1
					end, vim.v.oldfiles or {})

					if #files == 0 then
						return { { name = "no recent files", action = "", section = section } }
					end

					local cwd_pattern = "^" .. vim.pesc(vim.fn.getcwd()) .. "%/"
					files = vim.tbl_filter(function(f)
						return f:find(cwd_pattern) ~= nil
					end, files)

					if #files == 0 then
						return { { name = "no recent files", action = "", section = section } }
					end

					local items = {}
					for _, f in ipairs(vim.list_slice(files, 1, 5)) do
						local name = vim.fn.fnamemodify(f, ":t")
						table.insert(items, { action = "edit " .. f, name = name, section = section })
					end

					return items
				end,
			},
			content_hooks = {
				starter.gen_hook.adding_bullet("- "),
				starter.gen_hook.aligning("center", "center"),
			},
		})
	end,
}
return module
