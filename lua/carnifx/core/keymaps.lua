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

keymap.set("n", "<C-j>", "5j")
keymap.set("v", "<C-j>", "5j")

keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")
keymap.set("n", "<leader>wq", ":wq<CR>")

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
-- map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- diffview
keymap.set("n", "<leader>do", ":DiffviewOpen<CR>")
keymap.set("n", "<leader>dc", ":DiffviewClose<CR>")

-- gitsigns
keymap.set("n", "hd", ":Gitsigns next_hunk<CR>")
keymap.set("n", "he", ":Gitsigns prev_hunk<CR>")
keymap.set("n", "hv", ":Gitsigns preview_hunk<CR>")
keymap.set("n", "hs", ":Gitsigns stage_hunk<CR>")
keymap.set("n", "ha", ":Gitsigns undo_stage_hunk<CR>")
keymap.set("n", "hr", ":Gitsigns reset_hunk<CR>")
keymap.set("n", "bl", ":Gitsigns blame_line<CR>")
