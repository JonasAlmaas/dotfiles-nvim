return {
	--[[{
		'ellisonleao/gruvbox.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('gruvbox').setup({
				terminal_colors = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				}
			});
		end
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require('rose-pine').setup({
				styles = {
					bold = false,
					italic = false,
				}
			});
		end
	},
	{
		'rebelot/kanagawa.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('kanagawa').setup({
				commentStyle = { italic = false },
				keywordStyle = { italic = false },
			});
		end
	},]]
	{
		"uhs-robert/oasis.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("oasis").setup({
				styles = {
					bold = false,
					italic = false,
				},
				terminal_colors = true,
			});
			vim.cmd.colorscheme("oasis-abyss");
		end
	}
}
