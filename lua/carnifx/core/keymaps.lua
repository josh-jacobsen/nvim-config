-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
---- General Keymaps
-----------------------

-- exit insert mode
keymap.set("i", "jk", "<ESC>")
-- map Ctl c to Escape so I don't have to move my fingers when trying to get
-- out of the thing I just got myself into
keymap.set("n", "<C-c>", "<Esc>")
-- find all instances of variable in current file
keymap.set("n", "ss", "*")

keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")
keymap.set("n", "<leader><leader>q", ":q!<CR>")
keymap.set("n", "<leader>wq", ":wq<CR>")
vim.keymap.set("n", "<leader>wa", ":wa<CR>")
-- clear search highlights
keymap.set("n", "cl", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- find .env file, which is otherwise hidden from telescope
keymap.set("n", "ee", "")

-- set new file format to dos
keymap.set("n", "ffd", ":set ff=dos<CR>")

-- increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- navigate to start/end of lines in normal and visual modes
keymap.set({ "n", "v" }, "zz", "0")
keymap.set({ "n", "v" }, "mm", "$")
-- delete to start/end of line
keymap.set({ "n", "v" }, "dz", "d0")
keymap.set({ "n", "v" }, "dm", "d$")

-- when jumping up/down using Ctrl-d / Ctrl-u, keep cursor in the middle of the screen
-- to make the jump less jarring
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- When code is selected, use J and K to move the blocks up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
---- Plugin Keybinds
----------------------

---- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>le", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>lf", ":NvimTreeFindFile<CR>") -- Locate current file in explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- diffview
keymap.set("n", "<leader>do", ":DiffviewOpen<CR>")
keymap.set("n", "<leader>dc", ":DiffviewClose<CR>")

-- gitsigns
keymap.set("n", ",d", ":Gitsigns next_hunk<CR>")
keymap.set("n", ",e", ":Gitsigns prev_hunk<CR>")
keymap.set("n", ",v", ":Gitsigns preview_hunk<CR>")
keymap.set("n", ",s", ":Gitsigns stage_hunk<CR>")
keymap.set("n", ",a", ":Gitsigns undo_stage_hunk<CR>")
keymap.set("n", ",r", ":Gitsigns reset_hunk<CR>")
keymap.set("n", "bl", ":Gitsigns blame_line<CR>")

-- neotest
keymap.set("n", "tt", "<cmd>lua require('neotest').run.run()<cr>") -- run closest test
keymap.set("n", "tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>") -- run the file
keymap.set("n", "tso", "<cmd>lua require('neotest').summary.open()<cr>")
keymap.set("n", "tsc", "<cmd>lua require('neotest').summary.close()<cr>")
keymap.set("n", "too", "<cmd>lua require('neotest').output_panel.open()<cr>")
keymap.set("n", "toc", "<cmd>lua require('neotest').output_panel.close()<cr>")

-- terminal
keymap.set("n", "<leader><leader>t", "<cmd>terminal<cr>")

-- add ESC and jk as shortcuts to exit insert mode in terminal
local function set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = [[term://*]],
	callback = set_terminal_keymaps,
})
