return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		local gruvbox = require('gruvbox');

		gruvbox.setup({
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
