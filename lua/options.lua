-- General Neovim options

local options = {
	-- Show a single status line across the bottom of the screen for all
	-- windows/splits, instead of one per window. See :help 'laststatus'
	laststatus = 3,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end
