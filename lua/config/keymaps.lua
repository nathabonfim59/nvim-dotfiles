-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear search highlighting on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "Open [d]iagnostic quickfix list" })

-- Define function first
local function delete_quickfix_items(start_line, end_line)
	if vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].quickfix ~= 1 then
		print("Not in a quickfix window")
		return
	end

	local qf_list = vim.fn.getqflist()
	local items_to_remove = end_line - start_line + 1

	if start_line < 1 or end_line > #qf_list then
		print("Invalid quickfix range")
		return
	end

	for i = start_line, end_line do
		table.remove(qf_list, start_line)
	end

	vim.fn.setqflist(qf_list, "r")

	-- Adjust cursor position after deletion
	local new_pos = math.min(start_line, #qf_list)
	vim.fn.setpos(".", { 0, new_pos, 1, 0 })

	-- Refresh the quickfix window
	vim.cmd("cbottom")
	vim.cmd("copen")

	print(string.format("Deleted %d quickfix item(s)", items_to_remove))
end

-- Create the two-step grep functionality
vim.keymap.set("n", "<leader>st", function()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local finders = require("telescope.finders")
	local pickers = require("telescope.pickers")
	local conf = require("telescope.config").values

	-- Step 1: Select directory
	pickers
		.new({}, {
			prompt_title = "Select Directory for Grep",
			finder = finders.new_oneshot_job({ "fd", "--type", "d", "--hidden", "--exclude", ".git" }, {}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)

					-- Step 2: Live grep in the selected directory
					require("telescope.builtin").live_grep({
						prompt_title = "Grep in: " .. selection[1],
						cwd = selection[1],
					})
				end)
				return true
			end,
		})
		:find()
end, { desc = "[S]earch [T]wo-step grep" })

vim.keymap.set("n", "<leader>qD", function()
	delete_quickfix_items(vim.fn.line("."), vim.fn.line("."))
end, { desc = "[D]elete current quickfix item" })

-- Visual mode: Delete selected items
vim.keymap.set("v", "<leader>qd", function()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	delete_quickfix_items(start_line, end_line)
end, { desc = "[D]elete selected quickfix items" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Treesitter context toggle
vim.keymap.set("n", "<leader>ct", ":TSContextToggle<CR>", {
	desc = "Toggle [C]ode Con[t]ext",
})

-- Database browser
vim.keymap.set("n", "<leader>db", ":Dbee<CR>", {
	desc = "[D]atabase [B]rowser",
})

-- Open LazyGit with toggleterm within neovim
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

-- Open jid (json filter) with toggleterm within neovim
vim.keymap.set("n", "<leader>ti", function()
	local current_file = vim.fn.expand("%:p")
	local handle = io.popen("which jid")

	if handle == nil then
		return
	end

	local result = handle:read("*a")
	handle:close()

	-- If the `which` command returned a result, jid is installed
	if result ~= "" then
		-- Open LazyGit within a terminal in neovim
		vim.api.nvim_command("tabnew")
		vim.api.nvim_command("silent terminal jid < '" .. current_file .. "'")

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
		print("jid is not installed on this system.")
	end
end, { desc = "[T]erminal - Open in j[i]d" })

-- Harpoon keymaps
vim.keymap.set("n", "<leader>hh", function()
	require("harpoon.ui").toggle_quick_menu()
end, { desc = "Toggle [H]arpoon menu" })

vim.keymap.set("n", "<leader>ha", function()
	require("harpoon.mark").add_file()
end, { desc = "[H]arpoon [A]dd file" })

vim.keymap.set("n", "<leader>hj", function()
	require("harpoon.mark").nav_next()
end, { desc = "[H]arpoon Next file" })

vim.keymap.set("n", "<leader>hk", function()
	require("harpoon.mark").nav_prev()
end, { desc = "[H]arpoon prev file" })