-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

-- import telescope-ui-select safely
local themes_setup, themes = pcall(require, "telescope.themes")
if not themes_setup then
	return
end

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden" },
			layout_config = {
				height = 0.70,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			themes.get_dropdown({}),
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
