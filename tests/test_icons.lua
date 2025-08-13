-- Icon library for test suite
-- Supports both Nerd Font and standard Unicode icons

local M = {}

-- Try to detect if we have Nerd Font support
-- This is a simplified check for the test environment
local have_nerd_font = true

-- Define icons with Nerd Font versions as first option and Unicode fallbacks
M.success = have_nerd_font and "✔" or "✅"
M.failure = have_nerd_font and "✗" or "❌"
M.test = have_nerd_font and "" or "🧪"
M.install = have_nerd_font and "⬇" or "🔧"
M.clean = have_nerd_font and "" or "🧹"
M.refresh = have_nerd_font and "" or "🔄"
M.health = have_nerd_font and "✚" or "🏥"
M.robot = have_nerd_font and "󰚩" or "🤖"
M.clipboard = have_nerd_font and "" or "📋"
M.chart = have_nerd_font and "󰄀" or "📊"

return M

