#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BAKDIR="$HOME/.dotfiles.bak/$(date +%Y%m%d_%H%M%S)"

# directories under ~/.config to link
CONFIG_DIRS=(
    "fastfetch"
    "kitty"
    "niri"
    "noctalia"
    "rofi"
    "yazi"
    "zsh"
    "nvim"
)

# custom relative paths: "source_rel:dest_abs"
CUSTOM_LINKS=(
    ".local/share/noctalia:$HOME/.local/share/noctalia"
    "Pictures/Wallpapers:$HOME/Pictures/Wallpapers"
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

# run
echo "==> Linking ~/.config directories..."
for dir in "${CONFIG_DIRS[@]}"; do
    link_item "$DOTDIR/.config/$dir" "$HOME/.config/$dir"
done

echo "==> Linking custom paths..."
for entry in "${CUSTOM_LINKS[@]}"; do
    src_rel="${entry%%:*}"
    dest_abs="${entry#*:}"
    link_item "$DOTDIR/$src_rel" "$dest_abs"
done

# ensure ~/.zshrc points to .config/zsh/.zshrc if zsh config exists
if [ -f "$HOME/.config/zsh/.zshrc" ]; then
    link_item "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
fi

echo "==> Dotfiles setup complete."
if [ -d "$BAKDIR" ]; then
    echo "    Backups saved in: $BAKDIR"
fi
