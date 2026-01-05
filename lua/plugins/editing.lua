return {
	-- Harpoon for file navigation
	{
		"ThePrimeagen/harpoon",
		config = function()
			-- Harpoon keymaps are defined in config/keymaps.lua
		end,
	},

	-- Bookmarks.nvim for bookmarking files and positions
	{
		"LintaoAmons/bookmarks.nvim",
		-- pin the plugin at specific version for stability
		-- backup your bookmark sqlite db when there are breaking changes (major version change)
		tag = "3.2.0",
		dependencies = {
			{ "kkharji/sqlite.lua" },
			{ "nvim-telescope/telescope.nvim" }, -- currently has only telescopes supported, but PRs for other pickers are welcome
			{ "stevearc/dressing.nvim" }, -- optional: better UI
			{ "GeorgesAlkhouri/nvim-aider" }, -- optional: for Aider integration
		},
		config = function()
			local opts = {
				treeview = {
					window_split_dimension = 60,
				},
			} -- check the "./lua/bookmarks/default-config.lua" file for all the options
			require("bookmarks").setup(opts) -- you must call setup to init sqlite db
		end,

		keys = {
			{ "<leader>bb", "<cmd>BookmarksTree<cr>", desc = "Toggle Bookmark Tree" },
			{ "<leader>ba", "<cmd>BookmarksMark<cr>", desc = "Add Bookmark" },
			{ "<leader>bs", "<cmd>BookmarksQuery<cr>", desc = "Search Bookmarks" },
			{ "<leader>bl", "<cmd>BookmarksList<cr>", desc = "Show lists" },

			-- Current list
			{ "leader>bj", "<cmd>BookmarksGotoNextInList<cr>", desc = "Go to Next Bookmark in CR" },
			{ "leader>bk", "<cmd>BookmarksGotoPrevInList<cr>", desc = "Go to Previous Bookmark CR" },

			-- Global list
			{ "leader>bJ", "<cmd>BookmarksGotoNext<cr>", desc = "Go to Next Bookmark GL" },
			{ "leader>bK", "<cmd>BookmarksGotoPrev<cr>", desc = "Go to Previous Bookmark GL" },
		},
	},

	-- Kulala for HTTP requests
	{
		"mistweaverco/kulala.nvim",
		keys = {
			{ "<leader>Rs", desc = "Send request" },
			{ "<leader>Ra", desc = "Send all requests" },
			{ "<leader>Rb", desc = "Open scratchpad" },
		},
		ft = { "http", "rest" },
		opts = {
			global_keymaps = true,
			global_keymaps_prefix = "<leader>R",
			kulala_keymaps_prefix = "",
		},
	},
}
