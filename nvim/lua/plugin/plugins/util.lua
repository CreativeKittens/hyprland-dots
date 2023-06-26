return {
	-- Indent blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = "│",
			context_char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
			--[[ show_current_context = true, ]]
		},
	},

	-- Vim surround
	{
		"tpope/vim-surround",
	},

	-- Colorizer
	{
		"norcalli/nvim-colorizer.lua",
		main = "colorizer",
		opts = {
			"*",
			DEFAULT_OPTIONS = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				mode = "background", -- Set the display mode.
			},
		},
	},

	-- Autopairs
	{
		"jiangmiao/auto-pairs",
		init = function()
			vim.g.AutoPairsShortcutJump = ""
		end,
	},

	-- Notify
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},

	-- Noice
	{
		"folke/noice.nvim",
		--[[ event = "VeryLazy", ]]
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			}, -- add any options here
		},
	},

	-- Barbecue
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			theme = "catppuccin",
			exclude_filetypes = { "NvimTree", "toggleterm" },
		},
	},

	-- Multi visual
	{
		"mg979/vim-visual-multi",
		branch = "master",
	},
}
