return {
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					'c', 'javascript', 'typescript'
				}
			});
		end
	}
}
