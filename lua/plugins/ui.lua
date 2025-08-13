return {
	-- Which-key for keybind hints
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>c_", hidden = true },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>d_", hidden = true },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>r_", hidden = true },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>s_", hidden = true },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>w_", hidden = true },
				{
					mode = { "n", "v" },
					{ "<leader>g", group = "[G]it" },
					{ "<leader>g_", hidden = true },
					{ "<leader>p", group = "Co[P]ilot" },
					{ "<leader>p_", hidden = true },
					{ "<leader>pc", group = "Co[P]ilot [C]hat" },
					{ "<leader>pc_", hidden = true },
					{ "<leader>q", group = "[Q]uickfix Operations" },
					{ "<leader>q_", hidden = true },
					{ "<leader>t", group = "[T]Terminal" },
					{ "<leader>t_", hidden = true },
				},
			})
		end,
	},

	-- Todo comments highlighting
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- Mini.nvim collection
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Git integration
			require("mini.git").setup()

			-- Highlight the word under the cursor
			require("mini.cursorword").setup()

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			local function get_relative_to_root()
				local rel = vim.fn.expand("%:.") -- "%" → filename, ":." → make it relative to cwd
				if rel == "" or rel == "." then -- fallback for unnamed buffers
					return "[No Name]"
				end
				return rel
			end

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({
				use_icons = vim.g.have_nerd_font,
				content = {
					inactive = get_relative_to_root,
				},
			})

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			statusline.section_filename = function()
				return vim.fn.expand("%:.")
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},

	-- Undo tree
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{
				"<leader>H",
				function()
					require("undotree").toggle()
				end,
				mode = "",
				desc = "Toggle undotree [H]istory",
			},
		},
	},

	-- Color preview
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
}