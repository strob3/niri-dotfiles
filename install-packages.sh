#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKGS_FILE="$DOTDIR/packages.txt"
FLATPAKS_FILE="$DOTDIR/flatpaks.txt"

# 1. dnf pkgs
if [ -f "$PKGS_FILE" ]; then
    mapfile -t PKGS < <(grep -vE '^\s*(#|$)' "$PKGS_FILE" || true)
    if [ ${#PKGS[@]} -gt 0 ]; then
        if command -v dnf &>/dev/null; then
            echo "==> Installing ${#PKGS[@]} DNF packages..."
            sudo dnf install -y "${PKGS[@]}"
        else
            echo "==> Warning: dnf not found, skipping packages"
        fi
    fi
fi

# 2. flatpaks
if [ -f "$FLATPAKS_FILE" ]; then
    mapfile -t FLATPAKS < <(grep -vE '^\s*(#|$)' "$FLATPAKS_FILE" || true)
    if [ ${#FLATPAKS[@]} -gt 0 ]; then
        if command -v flatpak &>/dev/null; then
            echo "==> Setting up Flathub remote..."
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            echo "==> Installing ${#FLATPAKS[@]} Flatpaks..."
            flatpak install -y flathub "${FLATPAKS[@]}"
        else
            echo "==> Warning: flatpak not found, skipping Flatpaks"
        fi
    fi
fi

echo "==> Packages installation finished."
