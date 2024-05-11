local opt = vim.opt
local g = vim.g

vim.cmd [[
	set nowrap
	set nobackup
	set nowritebackup
	set noerrorbells
	set noswapfile
	set nofoldenable
]]

require("tokyonight").setup({
	style = "night",
	transparent = not g.neovide,
	hide_inactive_statusline = false,
	on_highlights = function(hl, c)
		hl.WinSeparator = {
			fg = c.fg_gutter,
		}
	end,

})
vim.cmd [[colorscheme tokyonight]]
if g.neovide then
	g.neovide_transparency = 0.8
	opt.guifont = "FiraCode Nerd Font Mono:h11.25"
end

vim.loader.enable()

-- enable folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"



require("guess-indent").setup()
require("ibl").setup() -- indent blankline

g.mapleader = ' '

opt.undofile = true
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.clipboard = "unnamedplus"


opt.mouse = "a"

opt.termguicolors = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.lazyredraw = true

opt.hidden = true


opt.viminfo = ""
opt.viminfofile = "NONE"

opt.smartcase = true
opt.incsearch = true
opt.hidden = true
opt.scrolloff = 6
opt.sidescrolloff = 20
