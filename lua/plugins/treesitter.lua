return {
	-- Treesitter parser and query installer
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter",
		opts = {},
		-- Install parsers after setup
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
			-- Install parsers asynchronously
			require("nvim-treesitter").install({
				"bash",
				"c",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"vim",
				"vimdoc",
				"svelte",
			})
		end,
	},
	-- Sticky scroll context (with treesitter)
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
}
