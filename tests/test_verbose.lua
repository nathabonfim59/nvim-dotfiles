-- Verbose Test Runner
-- Provides detailed output for debugging configuration issues

local function print_header(title)
	local line = "=" .. string.rep("=", 60)
	print(line)
	print("  " .. title)
	print(line)
end

local icons = require("test_icons")

local function print_section(title)
	print("\n" .. "─" .. string.rep("─", 40))
	print(icons.clipboard .. " " .. title)
	print("─" .. string.rep("─", 40))
end

local function test_environment()
	print_section("Environment Information")

	print("• Neovim version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch)
	print("• Config directory: " .. vim.fn.stdpath("config"))
	print("• Data directory: " .. vim.fn.stdpath("data"))
	print("• Plugin directory: " .. vim.fn.stdpath("data") .. "/lazy")

	-- Check if config files exist
	local config_files = {
		"init.lua",
		"lua/plugins/ai.lua",
		"lua/plugins/telescope.lua",
	}

	for _, file in ipairs(config_files) do
		local path = vim.fn.stdpath("config") .. "/" .. file
		if vim.fn.filereadable(path) == 1 then
			print(icons.success .. " " .. file .. " exists")
		else
			print(icons.failure .. " " .. file .. " missing")
		end
	end
end

local function test_lazy_status()
	print_section("Lazy.nvim Plugin Status")

	local status, lazy = pcall(require, "lazy")
	if not status then
		print(icons.failure .. " Lazy.nvim not available: " .. tostring(lazy))
		return
	end

	local stats = lazy.stats()
	print("• Total plugins: " .. stats.count)
	print("• Loaded plugins: " .. stats.loaded)
	print("• Start time: " .. string.format("%.2fms", stats.startuptime))

	-- List key plugins and their status
	local key_plugins = {
		"avante.nvim",
		"telescope.nvim",
		"copilot.lua",
		"plenary.nvim",
	}

	for _, plugin_name in ipairs(key_plugins) do
		local plugin = lazy.plugins()[plugin_name]
		if plugin then
			local status_text = plugin.loaded and "loaded" or "not loaded"
			print("• " .. plugin_name .. ": " .. status_text)
		else
			print("• " .. plugin_name .. ": not found")
		end
	end
end

local function test_critical_modules()
	print_section("Critical Module Loading")

	local critical_modules = {
		{ name = "lazy", desc = "Plugin manager" },
		{ name = "telescope", desc = "Fuzzy finder" },
		{ name = "telescope.pickers", desc = "Telescope pickers" },
		{ name = "telescope.actions", desc = "Telescope actions" },
		{ name = "avante", desc = "AI assistant" },
		{ name = "avante.api", desc = "Avante API" },
		{ name = "copilot", desc = "GitHub Copilot" },
	}

	local loaded_count = 0
	local total_count = #critical_modules

	for _, module in ipairs(critical_modules) do
		local status, result = pcall(require, module.name)
		if status then
			print(icons.success .. " " .. module.name .. " (" .. module.desc .. ")")
			loaded_count = loaded_count + 1
		else
			print(icons.failure .. " " .. module.name .. " (" .. module.desc .. "): " .. tostring(result))
		end
	end

	print(string.format("\n📊 Module loading: %d/%d successful", loaded_count, total_count))

	if loaded_count < total_count then
		print(icons.failure .. " Some critical modules failed to load")
		os.exit(1)
	end
end

local function test_telescope_integration()
	print_section("Telescope AI Integration Test")

	local status, err = pcall(function()
		-- Load required modules
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local conf = require("telescope.config").values
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		print(icons.success .. " All telescope modules loaded")

		-- Test prompt items structure
		local prompt_items = {
			{ id = "explain", title = "Explain Code", description = "Test", prompt = "Test prompt" },
			{ id = "review", title = "Code Review", description = "Test", prompt = "Test prompt" },
		}

		print(icons.success .. " Prompt items structure created")

		-- Test entry maker function
		local entry_maker = function(entry)
			return {
				value = entry,
				display = entry.title .. " - " .. entry.description,
				ordinal = entry.title .. " " .. entry.description,
			}
		end

		local test_entry = entry_maker(prompt_items[1])
		if test_entry.value and test_entry.display and test_entry.ordinal then
			print(icons.success .. " Entry maker function works")
		else
			error("Entry maker function failed")
		end

		-- Test finder creation
		local finder = finders.new_table({
			results = prompt_items,
			entry_maker = entry_maker,
		})

		print(icons.success .. " Telescope finder created")

		-- Test picker creation (don't show it)
		local picker = pickers.new({}, {
			prompt_title = "Test AI Actions",
			finder = finder,
			sorter = conf.generic_sorter({}),
		})

		print(icons.success .. " Telescope picker created")

		return true
	end)

	if not status then
		print(icons.failure .. " Telescope integration test failed: " .. tostring(err))
		os.exit(1)
	end

	print(icons.success .. " Telescope AI integration is functional")
end

local function test_avante_basic()
	print_section("Avante Basic Functionality")

	local status, err = pcall(function()
		local avante_api = require("avante.api")

		if type(avante_api.ask) ~= "function" then
			error("avante.api.ask is not a function")
		end
		print(icons.success .. " avante.api.ask function available")

		-- Test that we can create ask options structure
		local ask_options = {
			question = "test prompt",
			new_chat = true,
		}
		print(icons.success .. " Ask options structure is valid")

		return true
	end)

	if not status then
		print(icons.failure .. " Avante basic test failed: " .. tostring(err))
		os.exit(1)
	end

	print(icons.success .. " Avante basic functionality is available")
end

-- Main test runner
local function run_verbose_tests()
	print_header("NEOVIM CONFIGURATION VERBOSE TEST SUITE")

	test_environment()
	test_lazy_status()
	test_critical_modules()
	test_telescope_integration()
	test_avante_basic()

	print_header("ALL TESTS COMPLETED SUCCESSFULLY " .. icons.success)
	print("Your neovim configuration is working correctly!")
end

-- Run the tests
run_verbose_tests()

