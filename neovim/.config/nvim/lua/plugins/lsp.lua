vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = {buffer = event.buf}

		vim.keymap.set('n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		vim.keymap.set('n', 'gD', "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.keymap.set('n', 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		vim.keymap.set('n', 'go', "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		vim.keymap.set('n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		vim.keymap.set('n', 'gs', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		vim.keymap.set('n', '<F2>', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
		vim.keymap.set('n', '<F4>', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	end
})

return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"vimls",
				-- "shfmt",
				-- "stylua",
			},
			automatic_installation = true,
		},
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{
				"folke/noice.nvim",
				opts = {
					popupmenu = {
						backend = "cmp",
					},
				},
			},
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end
				},
				sources = { name = "nvim_lsp" },
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete()
				}),
				view = { docs = { auto_open = true }, entries = { follow_cursor = true } }
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			-- "williamboman/mason.nvim",
			"rcarriga/nvim-notify",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			-- "hrsh7th/cmp-nvim-lsp",
			-- "folke/noice.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			local capabilities = vim.tbl_deep_extend("force",
				vim.lsp.protocol.make_client_capabilities(),
				require('cmp_nvim_lsp').default_capabilities()
			)
			-- mason_lspconfig.setup_handlers {
			-- 	function (server_name) -- default handler (optional)
			-- 		lspconfig[server_name].setup {
			-- 			capabilities = capabilities
			-- 		}
			-- 	end
			-- }
		end
	},
}
