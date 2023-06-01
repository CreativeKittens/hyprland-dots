return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = true,
		config = function()
			-- This is where you modify the settings for lsp-zero
			-- Note: autocompletion settings will not take effect

			require("lsp-zero.settings").preset({})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				"rafamadriz/friendly-snippets",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"onsails/lspkind.nvim",
			},
		},
		config = function()
			-- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
			-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp
			require("lsp-zero.cmp").extend()
			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = require("lsp-zero.cmp").action()

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = require("lspkind").cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
						symbol_map = {
							TypeParameter = "",
						},
					}),
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				experimental = {
					ghost_text = true,
					native = true,
				},
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			-- Null ls
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jay-babu/mason-null-ls.nvim" },
			{ "jose-elias-alvarez/typescript.nvim" },
		},
		config = function()
			local lsp = require("lsp-zero")

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)

			-- Ensure install lsp
			lsp.ensure_installed({
				-- Replace these with whatever servers you want to install
				-- LSP'S
				"html",
				"cssls",
				"cssmodules_ls",
				"tsserver",
				"jsonls",
				"lua_ls",
				"clangd",
				"rust_analyzer",
				"intelephense",
				"yamlls",
				"bashls",
				"dockerls",
				"docker_compose_language_service",
			})

			-- Enable format on save
			lsp.format_on_save({
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["null-ls"] = {
						"html",
						"csss",
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"lua",
					},
				},
			})

			--- LSP Configuration will live here ---
			-- LUA
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

			-- Skip tsserver and uses typescript
			lsp.skip_server_setup({ "tsserver" })

			lsp.setup()

			-- Null-ls stuff will live here
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- Replace these with the tools you have installed
					null_ls.builtins.formatting.prettier.with({
						extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
					}),
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.formatting.stylua,
				},
			})

			require("mason-null-ls").setup({
				ensure_installed = nil,
				automatic_installation = true,
			})

			require("typescript").setup({
				server = {
					on_attach = function(client, bufnr)
						vim.keymap.set("n", "<leader>ci", "<cmd>TypescriptAddMissingImports<cr>", { buffer = bufnr })
					end,
				},
			})
		end,
	},
}
