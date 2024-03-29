print("reading luasnip")
if not pcall(require, "luasnip") then
	return
end

local ls = require("luasnip")
local types = require("luasnip.util.types")
-- neotest
ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = true,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets:
	enable_autosnippets = true,

	-- Crazy highlights!!
	-- #vid3
	-- ext_opts = nil,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " « ", "NonTest" } },
			},
		},
	},
})

-- <c-j> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- <c-k> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set("i", "<c-u>", require("luasnip.extras.select_choice"))

-- shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

-- vim.keymap.set("n", "<C-k>", "<cmd>lua require('luasnip').expand_or_jump()<cr>") -- run closest test
-- vim.keymap.set("n", "<C-k>", "<cmd>lua require('luasnip').jump(1)<cr>") -- run closest test
-- vim.keymap.set("n", "<C-j>", "<cmd>lua require('luasnip').jump(-1)<cr>") -- run closest test

-- local function silent_map(mode, lhs, rhs)
-- 	vim.keymap.set(mode, lhs, rhs, { silent = true })
-- end
--
-- silent_map("i", "<Plug>luasnip-expand-or-jump", function()
-- 	require("luasnip").expand_or_jump()
-- end)
-- silent_map("i", "<Plug>luasnip-expand-snippet", function()
-- 	require("luasnip").expand()
-- end)
-- silent_map("i", "<Plug>luasnip-next-choice", function()
-- 	require("luasnip").change_choice(1)
-- end)
-- silent_map("i", "<Plug>luasnip-prev-choice", function()
-- 	require("luasnip").change_choice(-1)
-- end)
-- silent_map("i", "<Plug>luasnip-jump-next", function()
-- 	require("luasnip").jump(1)
-- end)
-- silent_map("i", "<Plug>luasnip-jump-prev", function()
-- 	require("luasnip").jump(-1)
-- end)
--
-- silent_map("n", "<Plug>luasnip-delete-check", function()
-- 	require("luasnip").unlink_current_if_deleted()
-- end)
-- silent_map("!", "<Plug>luasnip-delete-check", function()
-- 	require("luasnip").unlink_current_if_deleted()
-- end)
--
-- silent_map("", "<Plug>luasnip-expand-repeat", function()
-- 	require("luasnip").expand_repeat()
-- end)
-- silent_map("!", "<Plug>luasnip-expand-repeat", function()
-- 	require("luasnip").expand_repeat()
-- end)
--
-- silent_map("s", "<Plug>luasnip-expand-or-jump", function()
-- 	require("luasnip").expand_or_jump()
-- end)
-- silent_map("s", "<Plug>luasnip-expand-snippet", function()
-- 	require("luasnip").expand()
-- end)
-- silent_map("s", "<Plug>luasnip-next-choice", function()
-- 	require("luasnip").change_choice(1)
-- end)
-- silent_map("s", "<Plug>luasnip-prev-choice", function()
-- 	require("luasnip").change_choice(-1)
-- end)
-- silent_map("s", "<Plug>luasnip-jump-next", function()
-- 	require("luasnip").jump(1)
-- end)
-- silent_map("s", "<Plug>luasnip-jump-prev", function()
-- 	require("luasnip").jump(-1)
-- end)
