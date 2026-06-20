-- Minimal Neovim configuration

-- Set <space> as the leader key (must be set before plugin/loading logic)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Open LazyGit in a terminal within neovim
vim.keymap.set("n", "<leader>gg", function()
	local handle = io.popen("which lazygit")

	if handle == nil then
		return
	end

	local result = handle:read("*a")
	handle:close()

	-- If the `which` command returned a result, LazyGit is installed
	if result ~= "" then
		-- Open LazyGit within a terminal in neovim
		vim.api.nvim_command("tabnew")
		vim.api.nvim_command("silent terminal lazygit")

		-- Redraw the terminal to fix resizing issue
		vim.api.nvim_command("redraw!")

		-- Remove line numbers
		vim.api.nvim_command("set nonumber")
		vim.api.nvim_command("set norelativenumber")

		-- Start in insert mode
		vim.api.nvim_command("startinsert")

		-- When the terminal process exits, close the buffer
		vim.api.nvim_command("autocmd TermClose <buffer> bd!")

		-- When exit, remove from recent buffers
		vim.api.nvim_command("autocmd BufLeave <buffer> bd!")
	else
		-- If LazyGit is not installed, print a message to the console
		print("LazyGit is not installed on this system.")
	end
end, { desc = "[G]it - Open Lazy[g]it" })
