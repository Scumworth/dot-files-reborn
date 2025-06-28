return {
	-- LSP completion source
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	-- Buffer completion source
	{
		"hrsh7th/cmp-buffer",
	},
	-- Path completion source
	{
		"hrsh7th/cmp-path",
	},
	-- Command line completion
	{
		"hrsh7th/cmp-cmdline",
	},
	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	-- Icons for completion menu
	{
		"onsails/lspkind.nvim",
	},
	-- Main completion plugin
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- Load snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Tab completion helper
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				mapping = cmp.mapping.preset.insert({
					-- Tab/Shift-Tab for completion navigation
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					-- Confirm completion
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false, -- Only confirm explicitly selected items
					}),

					-- Manual completion trigger
					["<C-Space>"] = cmp.mapping.complete(),

					-- Close completion menu
					["<C-e>"] = cmp.mapping.abort(),

					-- Scroll documentation
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Alternative navigation (Ctrl+n/p)
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
				}, {
					{ name = "buffer", priority = 500, keyword_length = 3 },
					{ name = "path", priority = 250 },
				}),

				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
						before = function(entry, vim_item)
							-- Source name indicators
							vim_item.menu = ({
								nvim_lsp = "[LSP]",
								luasnip = "[Snip]",
								buffer = "[Buf]",
								path = "[Path]",
							})[entry.source.name]
							return vim_item
						end,
					}),
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				completion = {
					completeopt = "menu,menuone,noinsert",
				},

				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
			})

			-- Command line completion
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- Highlight group for ghost text
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		end,
	},
}
