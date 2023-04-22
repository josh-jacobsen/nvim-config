local status, _ = pcall(vim.cmd, "colorscheme nightfly")

if not status then
	print("Colorscheme not found!")
	return
end

-- require("onedark").setup({
-- 	style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
-- })
-- require("onedark").load()
