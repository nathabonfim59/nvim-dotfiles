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
	{
		"ThePrimeagen/99",
		dependencies = {
			{ "nvim-telescope/telescope.nvim", optional = true },
		},
		config = function()
			local _99 = require("99")
			local Worker = require("99.extensions.work.worker")

			-- For logging that is to a file if you wish to trace through requests
			-- for reporting bugs, i would not rely on this, but instead the provided
			-- logging mechanisms within 99.  This is for more debugging purposes
			local cwd = vim.uv.cwd()
			local basename = vim.fs.basename(cwd)
			_99.setup({
				-- provider = _99.Providers.ClaudeCodeProvider,  -- default: OpenCodeProvider
				logger = {
					level = _99.DEBUG,
					path = "/tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},
				-- When setting this to something that is not inside the CWD tools
				-- such as claude code or opencode will have permission issues
				-- and generation will fail refer to tool documentation to resolve
				-- https://opencode.ai/docs/permissions/#external-directories
				-- https://code.claude.com/docs/en/permissions#read-and-edit
				tmp_dir = "./tmp",

				--- Completions: #rules and @files in the prompt buffer
				completion = {
					-- I am going to disable these until i understand the
					-- problem better.  Inside of cursor rules there is also
					-- application rules, which means i need to apply these
					-- differently
					-- cursor_rules = "<custom path to cursor rules>"

					--- A list of folders where you have your own SKILL.md
					--- Expected format:
					--- /path/to/dir/<skill_name>/SKILL.md
					---
					--- Example:
					--- Input Path:
					--- "scratch/custom_rules/"
					---
					--- Output Rules:
					--- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
					--- ... the other rules in that dir ...
					---
					custom_rules = {
						"scratch/custom_rules/",
					},

					--- Configure @file completion (all fields optional, sensible defaults)
					files = {
						-- enabled = true,
						-- max_file_size = 102400,     -- bytes, skip files larger than this
						-- max_files = 5000,            -- cap on total discovered files
						-- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
					},
					--- File Discovery:
					--- - In git repos: Uses `git ls-files` which automatically respects .gitignore
					--- - Non-git repos: Falls back to filesystem scanning with manual excludes
					--- - Both methods apply the configured `exclude` list on top of gitignore

					--- What autocomplete engine to use. Defaults to native (built-in) if not specified.
					source = "blink", -- "native" (default), "cmp", or "blink"
				},

				--- WARNING: if you change cwd then this is likely broken
				--- ill likely fix this in a later change
				---
				--- md_files is a list of files to look for and auto add based on the location
				--- of the originating request.  That means if you are at /foo/bar/baz.lua
				--- the system will automagically look for:
				--- /foo/bar/AGENT.md
				--- /foo/AGENT.md
				--- assuming that /foo is project root (based on cwd)
				md_files = {
					"AGENTS.md",
					"AGENT.md",
				},
			})

			-- Create your own short cuts for the different types of actions
			vim.keymap.set("n", "<leader>9", "", { desc = "99" })

			-- take extra note that i have visual selection only in v mode
			-- technically whatever your last visual selection is, will be used
			-- so i have this set to visual mode so i dont screw up and use an
			-- old visual selection
			--
			-- likely ill add a mode check and assert on required visual mode
			-- so just prepare for it now
			vim.keymap.set("v", "<leader>9v", function()
				_99.visual()
			end, { desc = "Execute on visual selection" })

			--- if you have a request you dont want to make any changes, just cancel it
			vim.keymap.set("n", "<leader>9x", function()
				_99.stop_all_requests()
			end, { desc = "Stop all requests" })

			vim.keymap.set("n", "<leader>9s", function()
				_99.search()
			end, { desc = "Search project with AI" })

			-- Vibe - Agentic coding mode
			vim.keymap.set("n", "<leader>9b", function()
				_99.vibe()
			end, { desc = "Vibe mode (agentic coding)" })

			-- Tutorial - Create AI tutorials
			vim.keymap.set("n", "<leader>9t", function()
				_99.tutorial()
			end, { desc = "Create AI tutorial" })

			-- Open - Browse previous requests
			vim.keymap.set("n", "<leader>9o", function()
				_99.open()
			end, { desc = "Open previous requests" })

			-- View logs
			vim.keymap.set("n", "<leader>9l", function()
				_99.view_logs()
			end, { desc = "View 99 logs" })

			-- Clear previous requests
			vim.keymap.set("n", "<leader>9c", function()
				_99.clear_previous_requests()
			end, { desc = "Clear previous requests" })

			-- Info - Show active rules and request counts
			vim.keymap.set("n", "<leader>9i", function()
				_99.info()
			end, { desc = "99 info" })

			-- Worker - Task tracking
			vim.keymap.set("n", "<leader>9w", function()
				Worker.set_work()
			end, { desc = "Set work item" })

			vim.keymap.set("n", "<leader>9r", function()
				Worker.search()
			end, { desc = "Search for remaining work" })

			vim.keymap.set("n", "<leader>9rv", function()
				Worker.vibe()
			end, { desc = "Vibe remaining work" })

			-- Model and Provider selection via Telescope
			local has_telescope, _ = pcall(require, "telescope")
			if has_telescope then
				vim.keymap.set("n", "<leader>9m", function()
					require("99.extensions.telescope").select_model()
				end, { desc = "Select AI model" })

				vim.keymap.set("n", "<leader>9p", function()
					require("99.extensions.telescope").select_provider()
				end, { desc = "Select AI provider" })
			end
		end,
	},
}
