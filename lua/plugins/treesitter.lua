return {
	-- Treesitter parser and query installer
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		main = "nvim-treesitter",
		init = function()
			if vim.fn.executable("tree-sitter") ~= 1 then
				vim.notify(
					[[tree-sitter CLI not found. Parsers will fail to compile.

Install it with one of:
  mise use -g tree-sitter@latest
  npm install -g tree-sitter-cli
  bun install -g tree-sitter-cli]],
					vim.log.levels.WARN,
					{ title = "nvim-treesitter" }
				)
			end
		end,
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"vim",
				"vimdoc",
				"svelte",
				"go",
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",
				"json",
			},
		},
	},
	-- Sticky scroll context (with treesitter)
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
}
