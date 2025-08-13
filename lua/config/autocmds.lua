-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

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

-- Quickfix window mappings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "dd", function()
			local current_line = vim.fn.line(".")
			delete_quickfix_items(current_line, current_line)
		end, { buffer = true })

		-- Visual mode mapping
		vim.keymap.set("v", "d", function()
			local start_line = vim.fn.line("'<")
			local end_line = vim.fn.line("'>")
			delete_quickfix_items(start_line, end_line)
		end, { buffer = true })
	end,
})

-- Blink CMP integration with Copilot
vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuOpen",
	callback = function()
		vim.b.copilot_suggestion_hidden = true
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuClose",
	callback = function()
		vim.b.copilot_suggestion_hidden = false
	end,
})

-- Check if has_words_before function is used elsewhere
local function has_words_before()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Defines the syntax for CakePHP's .ctp files as PHP
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.ctp",
	callback = function()
		vim.bo.syntax = "php"
	end,
	group = vim.api.nvim_create_augroup("FiletypeCTP", { clear = true }),
})

-- Astro file syntax highlighting
vim.cmd([[
  augroup FiletypeAstro
  autocmd!
  autocmd BufEnter *.astro lua vim.api.nvim_buf_set_option(0, 'syntax', 'astro')
  augroup END
]])