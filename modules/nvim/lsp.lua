local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
-- languages to use
lspconfig.clangd.setup {
	capabilities = capabilities,
}
lspconfig.pyright.setup {
	capabilities = capabilities,
}
lspconfig.nil_ls.setup {
	settings = {
		['nil'] = {
			formatting = {
				command = { "alejandra", "-qq" },
			},
		},
	},
	capabilities = capabilities,
}
require("neodev").setup({
	override = function(root_dir, library)
		if root_dir:find("nix-flake", 1, true) then
			library.enabled = true
			library.plugins = true
		end
	end
	-- add any options here, or leave empty to use the default settings
})
-- example to setup lua_ls and enable call snippets
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace"
			}
		}
	},
	capabilities = capabilities,
})

require 'lspconfig'.texlab.setup {
	capabilities = capabilities,
}

-- flutter
require 'flutter-tools'.setup {
	debugger = {
		enabled = true,
		run_via_dap = true,
	},
	widget_guides = {
		enabled = true,
	},
}

--- set hover to set filetype to markdown
local hoverfunc = vim.lsp.handlers["textDocument/hover"]
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
	local bufnr, winnr = hoverfunc(nil, result, ctx, config)
	---@diagnostic disable-next-line: param-type-mismatch
	vim.api.nvim_buf_set_option(bufnr, "filetype", "markdown")
	return bufnr, winnr
end



require("nvim-lightbulb").setup {
	autocmd = { enabled = true }
}

local map_keys = require("dr0med4r.utils").map_keys

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		local lsp_keymaps = {

			{ 'n', '<leader>e',  vim.diagnostic.open_float },
			{ 'n', '<leader>rn', vim.lsp.buf.rename },
			{ 'n', '<leader>gD', vim.lsp.buf.declaration },
			{ 'n', '<leader>gd', vim.lsp.buf.definition },
			{ 'n', 'K',          vim.lsp.buf.hover },
			{ 'n', '<leader>gi', vim.lsp.buf.implementation },
			{ 'n', '<C-k>',      vim.lsp.buf.signature_help },
			{ 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder },
			{ 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder },
			{ 'n', '<leader>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end },
			{ 'n', '<leader>D',  vim.lsp.buf.type_definition },
			{ 'n', '<leader>ca', vim.lsp.buf.code_action },
			{ 'n', 'gr',         vim.lsp.buf.references },
			{ 'n', 'ff', function()
				vim.lsp.buf.format { async = true }
			end }
		}
		map_keys(lsp_keymaps)
	end,
})
