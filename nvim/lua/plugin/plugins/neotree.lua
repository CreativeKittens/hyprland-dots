return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	event = "VimEnter",
	name = "neo-tree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = require("core.util").get_root() })
			end,
			silent = true,
		},
		{
			"<leader>E",
			function()
				require("neo-tree.command").execute({ focus = true, dir = require("core.util").get_root() })
			end,
			silent = true,
		},
	},
	opts = {
		close_if_last_window = false,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
		filesystem = {
			use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
			follow_current_file = true,
			filtered_items = {
				hide_by_name = {
					"node_modules",
				},
			},
			hijack_netrw_behavior = "open_current",
		},
		buffers = {
			follow_current_file = true, -- This will find and focus the file in the active buffer every
		},
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			indent = {
				indent_size = 2,
				padding = 1,
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				with_expanders = true,
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "󰷏",
				default = "",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					added = "A",
					modified = "M",
					deleted = "D",
					renamed = "R",
					untracked = "u",
					ignored = "I",
					unstaged = "U",
					staged = "S",
					conflict = "C",
				},
			},
		},
		window = {
			position = "left",
			width = 30,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<Tab>"] = {
					"toggle_node",
					nowait = false,
				},
				["<2-LeftMouse>"] = "open",
				["o"] = "open",
				["<esc>"] = "revert_preview",
				["P"] = { "toggle_preview", config = { use_float = true } },
				["l"] = "focus_preview",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				["t"] = "nop",
				["w"] = "open_with_window_picker",
				["C"] = "close_node",
				["z"] = "close_all_nodes",
				["a"] = {
					"add",
					config = {
						show_path = "none",
					},
				},
				["A"] = "add_directory",
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy",
				["m"] = "move",
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
			},
		},
		event_handlers = {
			{
				event = "neo_tree_window_after_open",
				handler = function(args)
					if args.position == "left" or args.position == "right" then
						vim.cmd("wincmd =")
					end
				end,
			},
			{
				event = "neo_tree_window_after_close",
				handler = function(args)
					if args.position == "left" or args.position == "right" then
						vim.cmd("wincmd =")
					end
				end,
			},
		},
	},
}
