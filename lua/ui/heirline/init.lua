module = {}

function module.init(use)
	use({
		"rebelot/heirline.nvim",
		requires = { { "kyazdani42/nvim-web-devicons" }, { "inadeqtfuturs/substrata.nvim" } },
		config = function()
			local os_sep = package.config:sub(1, 1)
			local api = vim.api
			local fn = vim.fn
			local bo = vim.bo

			local conditions = require("heirline.conditions")
			local heirline = require("heirline.utils")
			local get_hl = heirline.get_highlight

			local util = require("ui.heirline.util")
			local icons = util.icons
			local mode = util.mode

			local colors = require("substrata.colors").default

			local hl = {
				StatusLine = get_hl("StatusLine"),
				Git = {
					branch = { fg = colors.purple, bold = true },
					added = { fg = colors.green, bold = true },
					changed = { fg = colors.yellow, bold = true },
					removed = { fg = colors.red, bold = true },
				},
			}

			do
				local mode_colors = {
					normal = colors.grey2,
					op = colors.blue,
					insert = colors.blue,
					visual = colors.bg_yellow,
					visual_lines = colors.bg_yellow,
					visual_block = colors.bg_yellow,
					replace = colors.red,
					v_replace = colors.red,
					enter = colors.aqua,
					more = colors.aqua,
					select = colors.purple,
					command = colors.aqua,
					shell = colors.orange,
					term = colors.orange,
					none = colors.red,
				}
				hl.Mode = setmetatable({
					normal = { fg = mode_colors.normal },
				}, {
					__index = function(_, modename)
						return {
							-- fg = colors.black,
							fg = hl.StatusLine.bg,
							bg = mode_colors[modename],
							bold = true,
						}
					end,
				})
			end

			local priority = {
				CurrentPath = 60,
				Git = 40,
				WorkDir = 25,
				Lsp = 10,
			}

			local Space = setmetatable({ provider = " " }, {
				__call = function(_, n)
					return { provider = string.rep(" ", n) }
				end,
			})

			local ReadOnly = {
				condition = function()
					return not bo.modifiable or bo.readonly
				end,
				provider = icons.padlock,
				hl = hl.ReadOnly,
			}

			local LeftCap = {
				provider = "▌",
				-- provider = '',
				hl = hl.Mode.normal,
			}

			local ModeIndicator
			do
				local VimMode
				do
					local NormalModeIndicator = {
						Space,
						{
							fallthrough = false,
							ReadOnly,
							{
								provider = icons.circle,
								hl = function()
									if bo.modified then
										-- return { fg = hl.Mode.insert.bg }
										return { fg = colors.blue2 }
									else
										return hl.Mode.normal
									end
								end,
							},
						},
						Space,
					}

					local ActiveModeIndicator = {
						condition = function(self)
							return self.mode ~= "normal"
						end,
						hl = { bg = hl.StatusLine.bg },
						heirline.surround(
							{ icons.powerline.left_rounded, icons.powerline.right_rounded },
							function(self) -- color
								return hl.Mode[self.mode].bg
							end,
							{
								{
									fallthrough = false,
									ReadOnly,
									{ provider = icons.circle },
								},
								Space,
								{
									provider = function(self)
										return util.mode_lable[self.mode]
									end,
								},
								hl = function(self)
									return hl.Mode[self.mode]
								end,
							}
						),
					}

					VimMode = {
						init = function(self)
							self.mode = mode[fn.mode(1)] -- :h mode()
						end,
						condition = function()
							return bo.buftype == ""
						end,
						{
							fallthrough = false,
							ActiveModeIndicator,
							NormalModeIndicator,
						},
					}
				end

				Indicator = {
					fallthrough = false,
					VimMode,
				}
			end

			local Git
			do
				local GitBranch = {
					condition = conditions.is_git_repo,
					init = function(self)
						self.git_status = vim.b.gitsigns_status_dict
					end,
					hl = hl.Git.branch,
					provider = function(self)
						return table.concat({ " ", self.git_status.head, " " })
					end,
				}

				local GitChanges = {
					condition = function(self)
						if conditions.is_git_repo() then
							self.git_status = vim.b.gitsigns_status_dict
							local has_changes = self.git_status.added ~= 0
								or self.git_status.removed ~= 0
								or self.git_status.changed ~= 0
							return has_changes
						end
					end,
					{
						provider = function(self)
							local count = self.git_status.added or 0
							return count > 0 and table.concat({ "+", count, " " })
							-- return count > 0 and table.concat{'● ', count, ' '}
						end,
						hl = hl.Git.added,
					},
					{
						provider = function(self)
							local count = self.git_status.changed or 0
							return count > 0 and table.concat({ "~", count, " " })
							-- return count > 0 and table.concat{'● ', count, ' '}
						end,
						hl = hl.Git.changed,
					},
					{
						provider = function(self)
							local count = self.git_status.removed or 0
							return count > 0 and table.concat({ "-", count, " " })
							-- return count > 0 and table.concat{'● ', count, ' '}
						end,
						hl = hl.Git.removed,
					},
					Space,
				}

				Git = heirline.make_flexible_component(priority.Git, { GitBranch, GitChanges }, { GitBranch })
			end

			local StatusLine = {
				init = function(self)
					local pwd = fn.getcwd(0) -- Present working directory.
					local current_path = api.nvim_buf_get_name(0)
					local filename

					if current_path == "" then
						pwd = fn.fnamemodify(pwd, ":~")
						current_path = nil
						filename = " [No Name]"
					elseif current_path:find(pwd, 1, true) then
						filename = fn.fnamemodify(current_path, ":t")
						current_path = fn.fnamemodify(current_path, ":~:.:h")
						pwd = fn.fnamemodify(pwd, ":~") .. os_sep
						if current_path == "." then
							current_path = nil
						else
							current_path = current_path .. os_sep
						end
					else
						pwd = nil
						filename = fn.fnamemodify(current_path, ":t")
						current_path = fn.fnamemodify(current_path, ":~:.:h") .. os_sep
					end

					self.pwd = pwd
					self.current_path = current_path -- The opened file path relevant to pwd.
					self.filename = filename
				end,
				hl = hl.StatusLine,
				{
					LeftCap,
					ModeIndicator,
					Git,
				},
			}

			require("heirline").setup(StatusLine)
		end,
	})
end

return module
