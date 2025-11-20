return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		local gruvbox = require('gruvbox');

		gruvbox.setup({
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
}
