-- import null-ls plugin safely
local null_ls_setup, null_ls = pcall(require, "null-ls")
if not null_ls_setup then
	return
end

local eslint_setup, eslint = pcall(require, "eslint")
if not eslint_setup then
	return
end

-- null_ls.setup({})

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local code_actions = null_ls.builtins.code_actions -- for code actions
-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		-- diagnostics.eslint_d,
		-- code_actions.eslint_d,
		-- everything above this line is what I've been experimenting with

		-- sees like using the daemon version gives better results than the standard ones
-- 		-- null_ls.builtins.diagnostics.eslint_d,
-- 		-- null_ls.builtins.formatting.prettierd,
-- 		-- null_ls.builtins.code_actions.eslint_d,
-- 		-- require("typescript.extensions.null-ls.code-actions"),
-- 		diagnostics.eslint_d.with({ -- js/ts linter
-- 			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
-- 			condition = function(utils)
-- 				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
-- 			end,
-- 		}),
	},
-- 	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
--
-- eslint.setup({
-- 	bin = "eslint", -- or `eslint_d`
-- 	code_actions = {
-- 		enable = true,
-- 		apply_on_save = {
-- 			enable = true,
-- 			types = { "directive", "problem", "suggestion", "layout" },
-- 		},
-- 		disable_rule_comment = {
-- 			enable = true,
-- 			location = "separate_line", -- or `same_line`
-- 		},
-- 	},
-- 	diagnostics = {
-- 		enable = true,
-- 		report_unused_disable_directives = false,
-- 		run_on = "type", -- or `save`
-- 	},
-- })
