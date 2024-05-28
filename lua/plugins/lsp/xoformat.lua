local h = require("null-ls.helpers")
local cmd_resolver = require("null-ls.helpers.command_resolver")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

return h.make_builtin({
	name = "xo",
	method = FORMATTING,
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	factory = h.generator_factory,
	generator_opts = {
		command = "xo",
		args = { "--fix", "--reporter", "json", "--stdin", "--stdin-filename", "$FILENAME" },
		to_stdin = false,
		on_output = function(params)
			print(dump(params.content[1]))
			local parsed = params.output[1]
			return parsed
				and parsed.output
				and {
					{
						row = 1,
						col = 1,
						end_row = #vim.split(parsed.output, "\n") + 1,
						end_col = 1,
						text = parsed.output,
					},
				}
		end,
		dynamic_command = cmd_resolver.from_node_modules,
	},
})
