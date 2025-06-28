return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		vim.keymap.set('n', '<C-n>', '<Cmd>Neotree toggle<CR>')
		-- Auto Resize Windows when Neo-tree is toggled
		require("neo-tree").setup({
			event_handlers = {
				{
					event = "neo_tree_window_after_open",
					handler = function()
						vim.cmd("wincmd =")
					end
				},
				{
					event = "neo_tree_window_after_close",
					handler = function()
						vim.cmd("wincmd =")
					end
				}
			}
		})
	end
}
