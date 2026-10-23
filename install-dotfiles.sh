#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BAKDIR="$HOME/.dotfiles.bak/$(date +%Y%m%d_%H%M%S)"

# custom relative paths: "source_rel:dest_abs"
# paths outside of .config
CUSTOM_LINKS=(
    ".local/share/noctalia:$HOME/.local/share/noctalia"
    ".gitconfig:$HOME/.gitconfig"
)

# helper functions
link_item() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        echo "--> Skip (not found in repo): $src"
        return 0
    fi

    if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
        echo "--> OK (already linked): $dest"
        return 0
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "--> Backing up existing $dest -> $BAKDIR/"
        local rel_path="${dest#$HOME/}"
        mkdir -p "$BAKDIR/$(dirname "$rel_path")"
        mv "$dest" "$BAKDIR/$rel_path"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sfn "$src" "$dest"
    echo "--> Linked: $dest -> $src"
}

# 1. link ~/.config directories automatically
echo "==> Linking ~/.config directories..."
for src in "$DOTDIR/.config"/*; do
    [ -e "$src" ] || continue
    link_item "$src" "$HOME/.config/$(basename "$src")"
done

# 2. link ~/.local/bin scripts automatically
if [ -d "$DOTDIR/.local/bin" ]; then
    echo "==> Linking ~/.local/bin scripts..."
    mkdir -p "$HOME/.local/bin"
    for src in "$DOTDIR/.local/bin"/*; do
        [ -e "$src" ] || continue
        link_item "$src" "$HOME/.local/bin/$(basename "$src")"
    done
fi

# 3. link custom paths
echo "==> Linking custom paths..."
for entry in "${CUSTOM_LINKS[@]}"; do
    src_rel="${entry%%:*}"
    dest_abs="${entry#*:}"
    link_item "$DOTDIR/$src_rel" "$dest_abs"
done

# 4. zsh via ZDOTDIR (~/.zshenv)
if [ -d "$DOTDIR/.config/zsh" ]; then
    echo "==> Configuring Zsh via ZDOTDIR..."
    link_item "$DOTDIR/.zshenv" "$HOME/.zshenv"

    # clean legacy symlinks in $HOME if pointing to .config/zsh
    if [ -L "$HOME/.zshrc" ] && [ "$(readlink -f "$HOME/.zshrc")" = "$(readlink -f "$DOTDIR/.config/zsh/.zshrc")" ]; then
        rm "$HOME/.zshrc"
        echo "--> Removed legacy symlink: $HOME/.zshrc (now handled by ZDOTDIR)"
    fi
    if [ -L "$HOME/.p10k.zsh" ] && [ "$(readlink -f "$HOME/.p10k.zsh")" = "$(readlink -f "$DOTDIR/.config/zsh/.p10k.zsh")" ]; then
        rm "$HOME/.p10k.zsh"
        echo "--> Removed legacy symlink: $HOME/.p10k.zsh (now loaded from ZDOTDIR)"
    fi
fi

echo "==> Dotfiles setup complete."
if [ -d "$BAKDIR" ]; then
    echo "    Backups saved in: $BAKDIR"
fi
