return {
	'mbbill/undotree',

	config = function()
		-- 'diff' is not a default application on Windows
		vim.g.undotree_DiffCommand = "FC";

		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle);
	end
}
