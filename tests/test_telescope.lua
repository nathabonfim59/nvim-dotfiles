-- Telescope Integration Test Suite
-- Tests that telescope and its integrations work correctly

local icons = require("test_icons")

local function test_telescope_basic()
	print(icons.test .. " Testing basic telescope functionality...")

	local status, telescope = pcall(require, "telescope")
	if not status then
		print(icons.failure .. " Failed to load telescope: " .. tostring(telescope))
		os.exit(1)
	end

	-- Test telescope modules
	local modules_to_test = {
		"telescope.pickers",
		"telescope.finders",
		"telescope.actions",
		"telescope.actions.state",
		"telescope.config",
	}

	for _, module in ipairs(modules_to_test) do
		local mod_status, mod = pcall(require, module)
		if not mod_status then
			print(icons.failure .. " Failed to load " .. module .. ": " .. tostring(mod))
			os.exit(1)
		end
		print(icons.success .. " " .. module .. " loaded")
	end

	print(icons.success .. " Basic telescope functionality works!")
end

local function test_telescope_ai_integration()
	print(icons.robot .. " Testing telescope AI integration...")

	-- Test that we can create the telescope picker structure
	local status, err = pcall(function()
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local conf = require("telescope.config").values
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		-- Verify we can create the prompt items structure
		local prompt_items = {
			{
				id = "test",
				title = "Test Prompt",
				description = "Test description",
				prompt = "Test prompt text",
			},
		}

		-- Verify we can create the picker structure (don't actually show it)
		local picker_config = {
			prompt_title = "Test AI Actions",
			finder = finders.new_table({
				results = prompt_items,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.title .. " - " .. entry.description,
						ordinal = entry.title .. " " .. entry.description,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
		}

		-- Verify picker can be constructed
		local picker = pickers.new({}, picker_config)

		return picker ~= nil
	end)

	if not status then
		print(icons.failure .. " Telescope AI integration test failed: " .. tostring(err))
		os.exit(1)
	end

	print(icons.success .. " Telescope AI integration structure is valid!")
end

-- Run tests
print("Starting telescope integration tests...")
test_telescope_basic()
test_telescope_ai_integration()
print(icons.success .. " All telescope tests passed!")
