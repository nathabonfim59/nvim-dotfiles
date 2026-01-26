return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<leader>oa", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<leader>oc", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "t" }, "<leader>oo", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })

			vim.keymap.set({ "n", "x" }, "<leader>oaa", function()
				return require("opencode").operator("@this ")
			end, { expr = true, desc = "Add range to opencode" })
			vim.keymap.set("n", "<leader>oal", function()
				return require("opencode").operator("@this ") .. "_"
			end, { expr = true, desc = "Add line to opencode" })

			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "opencode half page up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "opencode half page down" })

			-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
			vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
			vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
		end,
	},
	-- Avante AI plugin
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	lazy = false,
	-- 	version = false, -- set this if you want to always pull the latest change
	-- 	opts = {
	-- 		provider = "opencode",
	-- 		auto_suggestions_provider = "copilot",
	-- 		auto_suggestions = false,
	-- 		providers = {
	-- 			copilot = {
	-- 				model = "gpt-5-mini",
	-- 			},
	-- 			["kimi-k2"] = {
	-- 				__inherited_from = "openai",
	-- 				endpoint = "https://openrouter.ai/api/v1",
	-- 				api_key_name = "OPENROUTER_API_KEY_AVANTE",
	-- 				model = "moonshotai/kimi-k2:novita",
	-- 				max_tokens = 131000,
	-- 				extra_body = {
	-- 					provider = {
	-- 						order = { "novita" },
	-- 						allow_fallbacks = false,
	-- 					},
	-- 				},
	-- 			},
	-- 			["zai-glm-4.6"] = {
	-- 				__inherited_from = "openai",
	-- 				endpoint = "https://api.cerebras.ai/v1",
	-- 				api_key_name = "CEREBRAS_QWEN_API_KEY",
	-- 				model = "qwen-3-coder-480b",
	-- 				max_tokens = 131000,
	-- 			},
	-- 		},
	-- 		-- Smart Tab (Automatic Suggestions) Configuration
	-- 		suggestion = {
	-- 			debounce = 600, -- Delay in ms before generating suggestions
	-- 			throttle = 600, -- Minimum delay between suggestion requests
	-- 		},
	-- 	},
	-- 	acp_providers = {
	-- 		["opencode"] = {
	-- 			command = "opencode",
	-- 			args = { "acp" },
	-- 		},
	-- 	},
	-- 	keys = {
	-- 		-- Show AI prompts actions with telescope
	-- 		{
	-- 			"<leader>pca",
	-- 			function()
	-- 				local pickers = require("telescope.pickers")
	-- 				local finders = require("telescope.finders")
	-- 				local conf = require("telescope.config").values
	-- 				local actions = require("telescope.actions")
	-- 				local action_state = require("telescope.actions.state")

	-- 				-- Define AI prompt options
	-- 				local prompt_items = {
	-- 					{
	-- 						id = "explain",
	-- 						title = "Explain Code",
	-- 						description = "Explain how the selected code works",
	-- 						prompt = "Please explain how this code works step by step, including its purpose, logic, and any important details.",
	-- 					},
	-- 					{
	-- 						id = "review",
	-- 						title = "Code Review",
	-- 						description = "Review code for potential issues and improvements",
	-- 						prompt = "Please review this code and suggest improvements. Look for potential bugs, performance issues, security concerns, and best practices.",
	-- 					},
	-- 					{
	-- 						id = "fix",
	-- 						title = "Fix Code",
	-- 						description = "Suggest fixes for code issues",
	-- 						prompt = "Please analyze this code and suggest fixes for any issues, bugs, or improvements that should be made.",
	-- 					},
	-- 					{
	-- 						id = "optimize",
	-- 						title = "Optimize Code",
	-- 						description = "Optimize code for better performance",
	-- 						prompt = "Please optimize this code for better performance, efficiency, and readability while maintaining the same functionality.",
	-- 					},
	-- 					{
	-- 						id = "tests",
	-- 						title = "Generate Tests",
	-- 						description = "Generate unit tests for the code",
	-- 						prompt = "Please generate comprehensive unit tests for this code, including edge cases and error scenarios.",
	-- 					},
	-- 					{
	-- 						id = "docs",
	-- 						title = "Generate Documentation",
	-- 						description = "Generate documentation for the code",
	-- 						prompt = "Please generate comprehensive documentation for this code, including function descriptions, parameters, return values, and usage examples.",
	-- 					},
	-- 					{
	-- 						id = "refactor",
	-- 						title = "Refactor Code",
	-- 						description = "Refactor code for better structure",
	-- 						prompt = "Please refactor this code to improve its structure, readability, and maintainability while preserving functionality.",
	-- 					},
	-- 					{
	-- 						id = "commit",
	-- 						title = "Generate Commit Message",
	-- 						description = "Generate a commit message for staged changes",
	-- 						prompt = "Please generate a concise and descriptive commit message for the staged changes, following conventional commit format.",
	-- 					},
	-- 				}

	-- 				pickers
	-- 					.new({}, {
	-- 						prompt_title = "Select AI Action",
	-- 						finder = finders.new_table({
	-- 							results = prompt_items,
	-- 							entry_maker = function(entry)
	-- 								return {
	-- 									value = entry,
	-- 									display = entry.title .. " - " .. entry.description,
	-- 									ordinal = entry.title .. " " .. entry.description,
	-- 								}
	-- 							end,
	-- 						}),
	-- 						sorter = conf.generic_sorter({}),
	-- 						attach_mappings = function(prompt_bufnr, map)
	-- 							actions.select_default:replace(function()
	-- 								local selection = action_state.get_selected_entry()
	-- 								actions.close(prompt_bufnr)

	-- 								-- Trigger Avante with selected prompt
	-- 								require("avante.api").ask({
	-- 									question = selection.value.prompt,
	-- 									new_chat = true,
	-- 								})
	-- 							end)
	-- 							return true
	-- 						end,
	-- 					})
	-- 					:find()
	-- 			end,
	-- 			desc = "Avante - AI Prompt Actions",
	-- 			mode = { "n", "v" },
	-- 		},
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"stevearc/dressing.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		{
	-- 			"zbirenbaum/copilot.lua",
	-- 		}, -- for providers='copilot'
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = false,
	-- 				},
	-- 			},
	-- 		},
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- },

	-- Github Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		--event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true, -- Enable auto-trigger
					debounce = 75,
					keymap = {
						accept = "<M-y>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				panel = { enabled = false },
			})
		end,
	},
}
