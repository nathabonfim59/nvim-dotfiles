-- Simple Avante Loading Test
-- Just tests that Avante can be loaded, no complex functionality testing

local icons = require("test_icons")

local function test_avante_loading()
	print(icons.robot .. " Testing Avante loading...")

	-- Test basic avante module loading
	local status, avante = pcall(require, "avante")
	if not status then
		print(icons.failure .. " Failed to load avante: " .. tostring(avante))
		os.exit(1)
	end
	print(icons.success .. " avante module loaded")

	-- Test avante.api module loading
	local api_status, avante_api = pcall(require, "avante.api")
	if not api_status then
		print(icons.failure .. " Failed to load avante.api: " .. tostring(avante_api))
		os.exit(1)
	end
	print(icons.success .. " avante.api module loaded")

	-- Check that ask function exists
	if type(avante_api.ask) ~= "function" then
		print(icons.failure .. " avante.api.ask is not a function")
		os.exit(1)
	end
	print(icons.success .. " avante.api.ask function is available")

	print(icons.success .. " Avante loading test passed!")
end

-- Run test
print("Starting Avante loading test...")
test_avante_loading()

