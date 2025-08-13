-- Load all plugin configurations
return {
	-- Basic utility plugins
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{ "numToStr/Comment.nvim", opts = {} }, -- "gc" to comment visual regions/lines
	{ "wakatime/vim-wakatime" },
	{ "NLKNguyen/papercolor-theme" },

	-- Import all other plugin configurations
	{ import = "plugins.ai" },
	{ import = "plugins.git" },
	{ import = "plugins.ui" },
	{ import = "plugins.telescope" },
	{ import = "plugins.lsp" },
	{ import = "plugins.completion" },
	{ import = "plugins.editing" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.colorscheme" },
	{ import = "plugins.utilities" },
}