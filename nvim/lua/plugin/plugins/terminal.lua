-- Toggleterm
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function(_, opts)
		function _G.set_terminal_keymaps()
			local optskey = { buffer = 0 }
			vim.keymap.set("t", "<A-n>", [[<C-\><C-n>]], optskey)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], optskey)
			vim.keymap.set("t", "<A-h>", [[<Cmd>wincmd h<CR>]], optskey)
			vim.keymap.set("t", "<A-k>", [[<Cmd>wincmd j<CR>]], optskey)
			vim.keymap.set("t", "<A-j>", [[<Cmd>wincmd k<CR>]], optskey)
			vim.keymap.set("t", "<A-l>", [[<Cmd>wincmd l<CR>]], optskey)
			vim.keymap.set("t", "<A-w>", [[<C-\><C-n><C-w>]], optskey)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		require("toggleterm").setup(opts)
	end,
	opts = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		return {--[[ things you want to change go here]]
			open_mapping = [[<c-`>]],
			autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened0
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			close_on_exit = true,
			shell = vim.o.shell,
			highlights = {
				FloatBorder = {
					guifg = mocha.blue,
				},
			},
			hide_number = false,
			direction = "float",
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		}
	end,
}
