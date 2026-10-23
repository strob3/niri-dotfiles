#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mode=""

usage() {
    cat <<EOF
Usage: $0 [OPTION]

Bootstrap dotfiles environment.

Options:
  --dots, -d        Install dotfiles symlinks only
  --pkgs, -p, --all Install packages (DNF/Flatpak) and dotfiles symlinks
  -h, --help        Show this help message

Without options, prompts interactively (defaults to dotfiles only).
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dots|-d)
            mode="dots"
            shift
            ;;
        --pkgs|-p|--all)
            mode="all"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

if [ -z "$mode" ]; then
    if [ -t 0 ]; then
        read -rp "Install packages via DNF & Flatpak? [y/N] " answer
        case "${answer:-n}" in
            [yY]|[yY][eE][sS])
                mode="all"
                ;;
            *)
                mode="dots"
                ;;
        esac
    else
        mode="dots"
    fi
fi

if [ "$mode" = "all" ]; then
    echo "==> Installing packages..."
    "$DOTDIR/install-packages.sh"
fi

echo "==> Linking dotfiles..."
"$DOTDIR/install-dotfiles.sh"
