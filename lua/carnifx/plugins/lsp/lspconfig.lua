-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- set keybinds
	keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show lspsaga table with references, definition, and implementation
	keymap.set("n", "gi", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
	keymap.set("n", "gj", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window

	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	-- I think I like the Lspsaga code actions dialogue more than the built in one
	-- keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions

	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	-- it would appear that this doesn't work
	-- keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- got to declaration

	--keymap.set("n", "gD", vim.lsp.buf.definition, opts) -- got to declaration

	-- I actually think I want to use the inbuilt commands for going to definition. Telescope keeps losing my place, so I can't retrace my steps with Ctrl O. This might
	-- not be a telescope thing but I want to experiment anywat
	-- keymap.set("n", "gf", "<cmd>Telescope lsp_definitions<CR>", opts) -- see definition and make edits in window
	nmap("gf", vim.lsp.buf.definition, "[G]oto [D]efinition")
	-- i dont think gi actually works
	-- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- go to implementation
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- go to definition of the type, if only 1, otherwise show all options
	-- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	-- keymap.set(
	-- 	"n",
	-- 	"gp",
	-- 	"<cmd>Telescope lsp_type_definitions<CR>",
	-- 	{ noremap = true, silent = true, buffer = bufnr, jump_type = "never" }
	-- ) -- go to definition of the type, if only 1, otherwise show all options

	keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
	keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
	keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
	keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure eslint
lspconfig["eslint"].setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})
-- try alternative tsserver setup
-- lspconfig["tsserver"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = function(client)
-- 		client.server_capabilities.document_formatting = false
-- 	end,
-- })

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
-- lspconfig["tailwindcss"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
