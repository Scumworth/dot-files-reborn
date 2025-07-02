# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview
This is a personal dot-files repository containing configurations for WezTerm terminal emulator and Neovim editor. Both tools are configured with the Catppuccin Mocha theme and integrated navigation keybindings.

## Common Development Tasks

### Neovim Plugin Management
- Plugins are managed via Lazy.nvim and automatically installed on first launch
- Add new plugins in `/nvim/lua/plugins/` as separate `.lua` files
- Run `:Lazy` in Neovim to manage plugins

### LSP and Formatting
- Language servers are managed via Mason (`:Mason` in Neovim)
- Auto-formatting runs on save for supported file types
- Manual format: `<leader>gf` in normal mode
- Code actions: `<leader>ca` in normal/visual mode

### Key Bindings Reference
- Leader key in Neovim: `<space>`
- Leader key in WezTerm: `Ctrl+a`
- Navigation between WezTerm panes and Neovim splits: `Ctrl+h/j/k/l`
- File explorer: `<leader>e` (Neo-tree)
- Fuzzy finder: `<leader>ff` (Telescope)
- LazyGit: `<leader>lg`

## Architecture Notes

### Configuration Structure
- `/nvim/init.lua` - Main Neovim configuration entry point
- `/nvim/lua/plugins/` - Individual plugin configurations (one file per plugin/feature)
- `/wezterm/wezterm.lua` - WezTerm terminal configuration

### Integration Points
- WezTerm and Neovim share navigation keybindings via the wezterm-navigation plugin
- Both use Catppuccin Mocha color scheme for visual consistency
- Claude Code plugin is configured for AI assistance within Neovim

### Language Support
The configuration includes LSP support for multiple languages including:
- TypeScript/JavaScript (ts_ls, eslint)
- Ruby (solargraph, rubocop)
- Python (pyright, black, isort)
- Elixir (elixir-tools with nextls)
- Lua (lua_ls, stylua)
- HTML/CSS (html, cssls, tailwindcss)
- And many others via Mason

When modifying configurations, ensure changes maintain consistency between WezTerm and Neovim where applicable (themes, navigation, etc.).