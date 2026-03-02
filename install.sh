#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

link_file() {
  local src="$1"
  local dst="$2"

  if [ ! -f "$src" ] && [ ! -d "$src" ]; then
    echo -e "${YELLOW} Skipped $src (not found)${NC}"
    return
  fi

  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -f "$dst" ] || [ -d "$dst" ]; then
    echo -e "${YELLOW} Backing up $dst → ${dst}.backup${NC}"
    mv "$dst" "${dst}.backup"
  fi

  ln -s "$src" "$dst"
  echo -e "${GREEN} $dst → $src${NC}"
}

echo "Creating symlinks..."

# Zsh
link_file "$DOTFILES_DIR/zsh/.zshrc"    "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link_file "$DOTFILES_DIR/zsh/.zshenv"   "$HOME/.zshenv"
link_file "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"

# Git
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Scripts
link_file "$DOTFILES_DIR/upgrade-node.sh" "$HOME/upgrade-node.sh"

# ~/.config
mkdir -p "$HOME/.config"
[ -d "$DOTFILES_DIR/config/gh" ]   && link_file "$DOTFILES_DIR/config/gh"   "$HOME/.config/gh"
[ -d "$DOTFILES_DIR/config/fish" ] && link_file "$DOTFILES_DIR/config/fish" "$HOME/.config/fish"

echo ""
echo -e "${GREEN}Done! Please restart your terminal or run: source ~/.zshrc${NC}"
