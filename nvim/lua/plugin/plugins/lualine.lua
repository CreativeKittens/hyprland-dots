return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VimEnter",
	opts = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		return {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { { "TelescopePrompt" } },
				ignore_focus = { "TelescopePrompt" },
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = {
							right = "",
						},
					},
					{
						"branch",
						separator = {
							right = "",
						},
						color = {
							bg = mocha.surface0,
							fg = mocha.text,
						},
					},
				},
				lualine_b = {
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ "filename", symbols = { modified = "󱇧", readonly = "󰈡", unnamed = "new file " } },
				},
				lualine_c = {
					{
						"diagnostics",
						update_in_insert = false,
						symbols = {
							error = " ",
							warn = "󱧡 ",
							info = "󰌵 ",
							hint = "󰛨 ",
						},
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "neo-tree", "lazy" },
		}
	end,
}
