-- VIM OPTIONS --
vim.opt.compatible = false
vim.cmd("filetype off")
vim.opt.modelines = 0
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"           -- Set encoding to UTF-8
vim.opt.showcmd = true               -- Display incomplete commands
vim.cmd("filetype plugin indent on") -- Load filetype plugins and indentation
vim.opt.autoindent = true            -- Enable auto-indentation
vim.opt.clipboard = "unnamed"
vim.opt.wrap = false                 -- Disable line wrapping
vim.opt.formatoptions = "qrn1"       -- Set format options

-- LEADER KEY --
vim.g.mapleader = " "      -- Set the global leader key to space
vim.g.maplocalleader = " " -- Set the local leader key to space

-- DISPLAY --
vim.opt.ruler = true    -- Always show info along the bottom
vim.opt.number = true   -- Show line numbers
vim.opt.undofile = true -- Enable persistent undo by creating an undo file

-- SEARCHING --
vim.opt.hlsearch = true   -- Highlight matches
vim.opt.incsearch = true  -- Enable incremental searching
vim.opt.ignorecase = true -- Case-insensitive searching...
vim.opt.smartcase = true  -- ...unless the search includes uppercase letters

-- COLORS --
-- rainbow
vim.g.rainbow_active = 1
-- optionally enable 24-bit color
vim.opt.termguicolors = true

-- RELOADING FILES --
vim.opt.autoread = true -- Reload buffer when file changes on disk
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	command = "checktime", -- Check for file changes when idle
})

-- TABS AND INDENTATION --
vim.opt.tabstop = 2                              -- A tab is two spaces (change to 4 if desired)
vim.opt.shiftwidth = 2                           -- Indent by two spaces
-- vim.opt.expandtab = true       -- Uncomment to use spaces instead of tabs (optional)
vim.opt.backspace = { "indent", "eol", "start" } -- Allow backspace through indents, line breaks, and insertion start

-- SPLIT BEHAVIOR
vim.opt.splitbelow = true    -- Open horizontal splits below the current window
vim.opt.splitright = true    -- Open vertical splits to the right of the current window
vim.opt.equalalways = true   -- Make all windows the same size when adding removing windows
vim.opt.eadirection = "both" -- Resize in both directions

-- Auto-resize splits when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = "wincmd =",
})

-- FIXED DIRECTORY LOCATIONS
vim.opt.undodir = vim.fn.expand("~/.vim/.undodir/")     -- Set undo directory
vim.opt.backupdir = vim.fn.expand("~/.vim/.backupdir/") -- Set backup directory
vim.opt.directory = vim.fn.expand("~/.vim/.swapdir/")   -- Set swap file directory

-- Allow switching buffers without saving changes
vim.opt.hidden = true

-- Disable backup and writebackup files (fixes issues with some servers)
vim.opt.backup = false
vim.opt.writebackup = false

-- Set command-line height to 1 for more space
vim.opt.cmdheight = 1

-- Reduce update time for better responsiveness
vim.opt.updatetime = 300

-- Don't pass messages to the completion menu
vim.opt.shortmess:append("c")

-- Always show the signcolumn
vim.opt.signcolumn = "yes"

-- GET OFF MY LAWN --
vim.keymap.set("n", "<Left>", ':echoe "Use h"<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", ':echoe "Use l"<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<Up>", ':echoe "Use k"<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", ':echoe "Use j"<CR>', { noremap = true, silent = true })

-- Window navigation handled by smart-splits plugin for WezTerm integration

vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })

-- Avoid shifting into colon mode with `;`
vim.keymap.set("n", ";", ":", { noremap = true, silent = true })

-- Cursor highlighting
vim.opt.cursorline = true -- Enable cursorline by default

-- Toggle cursorline with Leader+l
vim.keymap.set("n", "<Leader>l", ":set cursorline!<CR>", { noremap = true, silent = true })

vim.keymap.set(
	"n",
	"<space>e",
	":lua vim.diagnostic.open_float(0, {scope='line'})<CR>",
	{ noremap = true, silent = true }
)
-- Highlight settings for CursorLine and CursorLineNR
vim.cmd("hi CursorLine cterm=NONE ctermbg=black")
vim.cmd("hi CursorLineNR cterm=NONE ctermbg=black")

-- TMUX color support
if os.getenv("TMUX") then
	vim.g.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
	vim.g.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
end
-- LANGUAGE SPECIFIC CONFIGURATIONS --

-- JavaScript and TypeScript
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.tsx", "*.jsx" },
	command = "set filetype=typescriptreact",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.ts", "*.js" },
	command = "set filetype=typescriptreact",
})
-- Ruby
vim.g.rufo_auto_formatting = 1

-- HTML
vim.g.html_indent_tags = "li|p"

-- PLUGIN CONFIGURATION --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
