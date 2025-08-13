-- Plugin Loading Test Suite
-- Tests that all essential plugins can be loaded without errors

local icons = require("test_icons")

local function test_plugin_loading()
	local success_count = 0
	local failure_count = 0
	local failures = {}

	-- List of critical plugins to test
	local plugins_to_test = {
		-- Core plugins
		{ name = "lazy.nvim", module = "lazy" },
		{ name = "plenary.nvim", module = "plenary" },

		-- AI plugins
		{ name = "avante.nvim", module = "avante" },
		{ name = "avante.api", module = "avante.api" },
		{ name = "copilot.lua", module = "copilot" },

		-- Telescope and dependencies
		{ name = "telescope.nvim", module = "telescope" },
		{ name = "telescope.builtin", module = "telescope.builtin" },
		{ name = "telescope.pickers", module = "telescope.pickers" },
		{ name = "telescope.finders", module = "telescope.finders" },
		{ name = "telescope.actions", module = "telescope.actions" },

		-- UI plugins
		{ name = "dressing.nvim", module = "dressing" },

		-- LSP and completion
		{ name = "nvim-lspconfig", module = "lspconfig" },
		{ name = "nvim-cmp", module = "cmp" },

		-- Git integration
		{ name = "gitsigns.nvim", module = "gitsigns" },

		-- Treesitter
		{ name = "nvim-treesitter", module = "nvim-treesitter" },
	}

	print(icons.test .. " Testing plugin loading...")
	print("=" .. string.rep("=", 50))

	for _, plugin in ipairs(plugins_to_test) do
		local status, result = pcall(require, plugin.module)

		if status then
			print(icons.success .. " " .. plugin.name .. " (" .. plugin.module .. ")")
			success_count = success_count + 1
		else
			print(icons.failure .. " " .. plugin.name .. " (" .. plugin.module .. "): " .. tostring(result))
			failure_count = failure_count + 1
			table.insert(failures, {
				name = plugin.name,
				module = plugin.module,
				error = tostring(result),
			})
		end
	end

	print("=" .. string.rep("=", 50))
	print(
		string.format(icons.chart .. " Results: %d/%d plugins loaded successfully", success_count, success_count + failure_count)
	)

	if failure_count > 0 then
		print(icons.failure .. " Failed plugins:")
		for _, failure in ipairs(failures) do
			print("   • " .. failure.name .. ": " .. failure.error)
		end
		os.exit(1)
	else
		print(icons.success .. " All plugins loaded successfully!")
		os.exit(0)
	end
end

-- Test plugin configurations
local function test_plugin_configs()
	print(icons.install .. " Testing plugin configurations...")

	local config_tests = {
		{
			name = "Lazy.nvim configuration",
			test = function()
				local lazy = require("lazy")
				return type(lazy.stats) == "function"
			end,
		},
		{
			name = "Telescope configuration",
			test = function()
				local telescope = require("telescope")
				return type(telescope.setup) == "function"
			end,
		},
		{
			name = "Avante API availability",
			test = function()
				local avante_api = require("avante.api")
				return type(avante_api.ask) == "function"
			end,
		},
		{
			name = "Copilot configuration",
			test = function()
				local copilot = require("copilot")
				return type(copilot.setup) == "function"
			end,
		},
	}

	for _, test in ipairs(config_tests) do
		local status, result = pcall(test.test)
		if status and result then
			print(icons.success .. " " .. test.name)
		else
			print(icons.failure .. " " .. test.name .. ": " .. tostring(result))
			os.exit(1)
		end
	end

	print(icons.success .. " All plugin configurations are valid!")
end

-- Run tests
print("Starting plugin loading tests...")
test_plugin_loading()
test_plugin_configs()

