return {
	-- Git signs in the gutter
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		keys = {
			{
				"<leader>gs",
				":Gitsigns stage_hunk<CR>",
				mode = { "v", "n" },
				desc = "Git - Stage hunk",
			},
			{
				"<leader>gp",
				":Gitsigns preview_hunk<CR>",
				mode = "n",
				desc = "Git - Preview hunk",
			},
			{
				"<leader>gr",
				":Gitsigns reset_hunk<CR>",
				mode = "n",
				desc = "Git - Reset hunk",
			},
			{
				"<leader>gj",
				":Gitsigns next_hunk<CR>",
				mode = "n",
				desc = "Git - Next hunk",
			},
			{
				"<leader>gk",
				":Gitsigns prev_hunk<CR>",
				mode = "n",
				desc = "Git - Previous hunk",
			},
			{
				"<leader>gl",
				":Gitsigns blame_line<CR>",
				mode = "n",
				desc = "Git - Blame line",
			},
		},
	},

	-- Neogit - Git interface
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},
	},
}