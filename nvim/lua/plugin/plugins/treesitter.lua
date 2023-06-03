return {
	"nvim-treesitter/nvim-treesitter",
	main = "nvim-treesitter.configs",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"HiPhish/nvim-ts-rainbow2",
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-context",
		{
			"numToStr/Comment.nvim",
			opts = {
				pre_hook = function(ctx)
					local U = require("Comment.utils")

					local location = nil
					if ctx.ctype == U.ctype.block then
						location = require("ts_context_commentstring.utils").get_cursor_location()
					elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
						location = require("ts_context_commentstring.utils").get_visual_start_location()
					end

					return require("ts_context_commentstring.internal").calculate_commentstring({
						key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
						location = location,
					})
				end,
			},
		},
	},
	opts = {
		context_commentstring = {
			enable = true,
		},
		rainbow = {
			enable = true,
			query = {
				html = "rainbow-parens",
				vue = "rainbow-parens",
				jsx = "rainbow-parens-react",
				tsx = "rainbow-parens-reacn",
				python = "rainbow-parens",
			},
		},
		autotag = {
			enable = true,
		},
		ensure_installed = {
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"json",
			"lua",
			"c",
			"cpp",
			"python",
			"rust",
			"java",
			"php",
			"yaml",
			"bash",
			"dockerfile",
			"gitignore",
		},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		highlight = {
			enable = true,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Instead of true it can also be a list of languages
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			additional_vim_regex_highlighting = false,
		},
	},
}
