require("toggleterm").setup({
	direction = "float",
})
-- -- terminal
vim.keymap.set("n", "<leader>tl", ":ToggleTerm direction=horizontal size-15<CR>")
vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>")
