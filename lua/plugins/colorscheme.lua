return {
	-- JetBrains colorscheme
	{
		"nickkadutskyi/jb.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.opt.termguicolors = true
			-- vim.opt.background = "light"
			-- vim.cmd.colorscheme("PaperColor")
			vim.cmd.colorscheme("jb")
			-- vim.cmd.colorscheme("minischeme")

			-- Put everything in transparent background
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

			-- vim.cmd.hi("Comment gui=none")
			-- vim.cmd.hi("MiniStatuslineModeInsert guibg=#569CD6 guifg=#343434")
			-- vim.cmd.hi("MiniStatuslineModeNormal guibg=#254455 guifg=#5ad4e6")
			-- vim.cmd.hi("MiniStatuslineModeNormal guibg=#192D38 guifg=#5ad4e6")
			vim.cmd.hi("MiniStatuslineModeNormal guibg=#273335 guifg=#5ad4e6")
			vim.cmd.hi("Beacon guibg=#372d26")
			-- vim.cmd.hi("MiniStatuslineModeInsert", { bg = c.vscLeftDark, fg = c.vscFront })
			-- vim.cmd.hi("MiniStatuslineModeVisual", { bg = c.vscLeftDark, fg = c.vscFront })
			-- vim.cmd.hi("MiniStatuslineModeReplace", { bg = c.vscLeftDark, fg = c.vscFront })
			-- vim.cmd.hi("MiniStatuslineModeCommand", { bg = c.vscLeftDark, fg = c.vscFront })
			-- vim.cmd.hi("MiniStatuslineModeOther", { bg = c.vscLeftDark, fg = c.vscFront })
			--
			-- From context toggle
			vim.cmd.hi("TreesitterContextBottom gui=underline guisp=Grey")
			vim.cmd.hi("TreesitterContextLineNumberBottom gui=underline guisp=Grey")
		end,
	},
}