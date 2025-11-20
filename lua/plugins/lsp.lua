return {
	'neovim/nvim-lspconfig',

	dependencies = {
		'stevearc/conform.nvim',
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		'j-hui/fidget.nvim',
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},

	config = function()
		require('conform').setup({
			formatter_by_ft = {}
		});

		local cmp = require('cmp');
		local cmp_lsp = require('cmp_nvim_lsp');
		local capabilities = vim.tbl_deep_extend(
			'force',
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities());

		require('fidget').setup({});
		require('mason').setup();
		require('mason-lspconfig').setup({
			ensure_installed = {
				'clangd',
				'csharp_ls',
				'lua_ls',
				'tailwindcss'
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require('lspconfig')[server_name].setup({
						capabilities = capabilities
					});
				end,
				['tailwindcss'] = function()
					local lspconfig = require('lspconfig')
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						filetypes = {'html', 'css', 'javascript',  'typescript', 'svelte'},
					});
				end,
			}
		});

		local cmp_select = {behavior = cmp.SelectBehavior.Select};

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				['<C-y>'] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources(
				{
					{name = 'nvim_lsp'}
				},
				{
					{name = 'buffer'}
				}),
		});

		vim.diagnostic.config({
			--update_in_insert = true,
			float = {
				focusable = false,
				style = 'minimal',
				border = 'rounded',
				source = 'always',
				header = '',
				prefix = '',
			}
		});
	end
}
