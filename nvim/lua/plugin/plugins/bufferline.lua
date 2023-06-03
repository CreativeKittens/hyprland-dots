return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	keys = {
		{ "<S-l>", ":BufferLineCycleNext<CR>", silent = true },
		{ "<S-h>", ":BufferLineCyclePrev<CR>", silent = true },
		{
			"<leader>bd",
			function()
				require("core.util").buf_kill("bd", nil, true)
			end,
			silent = true,
		},
		{
			"<leader>bxh",
			":BufferLineCloseLeft<CR>",
			silent = true,
		},
		{
			"<leader>bxl",
			":BufferLineCloseRight<CR>",
			silent = true,
		},
		{
			"<leader>bp",
			":BufferLineTogglePin<CR>",
		},
	},
	opts = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		return {
			highlights = require("catppuccin.groups.integrations.bufferline").get({
				styles = { "italic", "bold" },
				custom = {
					mocha = {
						fill = { bg = mocha.mantle },
						separator = { fg = mocha.base },
						separator_selected = { fg = mocha.base },
						separator_visible = { fg = mocha.base },
						offset_separator = { bg = mocha.mantle, fg = mocha.mantle },
						indicator_selected = { fg = mocha.base },
						indicator_visible = { bg = mocha.base, fg = mocha.base },
						buffer_visible = { bg = mocha.base },
					},
				},
			}),
			options = {
				mode = "buffers",
				themeable = true,
				always_show_bufferline = true,
				close_command = function(bufnr)
					require("core.util").buf_kill("bd", bufnr, true)
				end,
				left_mouse_command = "buffer %d",
				right_mouse_command = "", -- can be a string | function | false, see "Mouse actions"
				middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
				indicator = {
					icon = "▎", -- this should be omitted if indicator style is not 'icon'
					style = "icon",
				},
				close_icon = " ",
				buffer_close_icon = "",
				show_close_icon = false,
				show_duplicate_prefix = false,
				separator_style = "",
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
						highlight = "Directory",
					},
				},
				custom_filter = function(buf, buf_nums)
					return not (vim.bo[buf].filetype == "neo-tree" or vim.bo[buf].filetype == "TelescopePrompt")
				end,
				hover = {
					enabled = true,
					delay = 0,
					reveal = { "close" },
				},
			},
		}
	end,
}
