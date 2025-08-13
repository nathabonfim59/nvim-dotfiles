return {
	-- Avante AI plugin
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			provider = "copilot",
			auto_suggestions_provider = "copilot",
			auto_suggestions = false,
			providers = {
				copilot = {
					model = "gpt-4o",
				},
				["kimi-k2"] = {
					__inherited_from = "openai",
					endpoint = "https://openrouter.ai/api/v1",
					api_key_name = "OPENROUTER_API_KEY_AVANTE",
					model = "moonshotai/kimi-k2:novita",
					max_tokens = 131000,
					extra_body = {
						provider = {
							order = { "novita" },
							allow_fallbacks = false,
						},
					},
				},
				["qwen-3-coder-480b"] = {
					__inherited_from = "openai",
					endpoint = "https://api.cerebras.ai/v1",
					api_key_name = "CEREBRAS_QWEN_API_KEY",
					model = "qwen-3-coder-480b",
					max_tokens = 131000,
				},
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				"zbirenbaum/copilot.lua",
			}, -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = false,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},

	-- Github Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		--event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = false,
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

	-- Copilot Chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = false, -- Enable debugging
			context = "buffers",
		},
		keys = {
			-- Show prompts actions with telescope
			{
				"<leader>pca",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
				mode = { "n", "v" },
			},
			{
				"<leader>pcp",
				function()
					require("CopilotChat").toggle({
						window = {
							layout = "horizontal",
						},
					})
				end,
				mode = "n",
				desc = "Open CopilotChat pane",
			},
			{
				"<leader>pcf",
				function()
					require("CopilotChat").toggle({
						window = {
							layout = "float",
							height = 0.8,
							width = 0.8,
						},
					})
				end,
				mode = "n",
				desc = "Open CopilotChat floating",
			},
			{
				"<leader>pci",
				function()
					require("CopilotChat").toggle({
						window = {
							layout = "float",
							relative = "cursor",
							width = 1,
							height = 0.4,
							row = 1,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Open CopilotChat inline",
			},
			{
				"<leader>pcq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "CopilotChat - Quick chat",
			},
			{
				"<leader>pce",
				"<cmd>CopilotChatExplain<cr>",
				mode = "v",
				desc = "AI Explain",
			},
			{
				"<leader>pcr",
				"<cmd>CopilotChatReview<cr>",
				mode = "v",
				desc = "AI Review",
			},
			{
				"<leader>pct",
				"<cmd>CopilotChatTests<cr>",
				mode = "v",
				desc = "AI Tests",
			},
			{
				"<leader>pcf",
				"<cmd>CopilotChatFix<cr>",
				mode = "v",
				desc = "AI Fix",
			},
			{
				"<leader>pco",
				"<cmd>CopilotChatOptimize<cr>",
				mode = "v",
				desc = "AI Optimize",
			},
			{
				"<leader>pcd",
				"<cmd>CopilotChatDocs<cr>",
				mode = "v",
				desc = "AI Documentation",
			},
			{
				"<leader>pcc",
				"<cmd>CopilotChatCommitStaged<cr>",
				mode = "v",
				desc = "AI Generate Commit",
			},
		},
		config = function()
			local chat = require("CopilotChat")
			chat.setup({})
		end,
	},
}

