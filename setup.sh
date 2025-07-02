#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}Setting up dotfiles from: $DOTFILES_DIR${NC}"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create parent directory if it doesn't exist
    local parent_dir="$(dirname "$target")"
    if [ ! -d "$parent_dir" ]; then
        echo -e "${YELLOW}Creating directory: $parent_dir${NC}"
        mkdir -p "$parent_dir"
    fi
    
    # Check if target already exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            # It's already a symlink, remove it
            echo -e "${YELLOW}Removing existing symlink: $target${NC}"
            rm "$target"
        else
            # It's a regular file/directory, back it up
            local backup="${target}_old"
            echo -e "${YELLOW}Backing up existing file: $target -> $backup${NC}"
            cp -r "$target" "$backup"
            rm -rf "$target"
        fi
    fi
    
    # Create the symlink
    echo -e "${GREEN}Creating symlink: $target -> $source${NC}"
    ln -s "$source" "$target"
}

# Neovim configuration
echo -e "\n${GREEN}=== Setting up Neovim ===${NC}"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# WezTerm configuration
echo -e "\n${GREEN}=== Setting up WezTerm ===${NC}"
create_symlink "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"

# Nushell configuration
echo -e "\n${GREEN}=== Setting up Nushell ===${NC}"
NUSHELL_CONFIG_DIR="$HOME/Library/Application Support/nushell"
create_symlink "$DOTFILES_DIR/nushell/env.nu" "$NUSHELL_CONFIG_DIR/env.nu"
create_symlink "$DOTFILES_DIR/nushell/config.nu" "$NUSHELL_CONFIG_DIR/config.nu"

# Zsh configuration
echo -e "\n${GREEN}=== Setting up Zsh ===${NC}"
create_symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# IdeaVim configuration
echo -e "\n${GREEN}=== Setting up IdeaVim ===${NC}"
create_symlink "$DOTFILES_DIR/idea/ideavimrc" "$HOME/.ideavimrc"

# Starship configuration
echo -e "\n${GREEN}=== Setting up Starship ===${NC}"
create_symlink "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# Git configuration (if you add one later)
if [ -f "$DOTFILES_DIR/gitconfig" ]; then
    echo -e "\n${GREEN}=== Setting up Git ===${NC}"
    create_symlink "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
fi

echo -e "\n${GREEN}✅ Dotfiles setup complete!${NC}"
echo -e "${YELLOW}Note: You may need to restart your terminal for changes to take effect.${NC}"