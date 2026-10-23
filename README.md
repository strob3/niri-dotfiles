# niri-dotfiles

Personal dotfiles built around niri and noctalia.

## Setup
```bash
git clone https://github.com/strob3/niri-dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# to include wallpaper repo
git clone --recurse-submodules https://github.com/strob3/niri-dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# run setup script
./setup.sh

# flags
./setup.sh --dots   # dotfiles symlinks only
./setup.sh --pkgs   # packages + dotfiles symlinks
```

## Usage 

### Editing Configs
Configs in `~/.config/` are symlinks to `~/.dotfiles/.config/`.
```bash
nvim ~/.config/niri/config.kdl
# changes are tracked in ~/.dotfiles
```

### Tracking New Configs

#### Under `~/.config/` (auto-detected)
```bash
# move config directory into dotfiles repo
mv ~/.config/foo ~/.dotfiles/.config/

# apply symlinks (auto-detects all folders in .config/)
./install-dotfiles.sh
```

#### Outside `~/.config/` (custom paths like `~/.gitconfig`)
```bash
# move file or directory into repo
mv ~/.gitconfig ~/.dotfiles/.gitconfig

# add entry to CUSTOM_LINKS in install-dotfiles.sh:
#   CUSTOM_LINKS=(
#       ".local/share/noctalia:$HOME/.local/share/noctalia"
#       ".gitconfig:$HOME/.gitconfig"
#   )

# apply symlinks
./install-dotfiles.sh
```

### Adding Packages or Flatpaks
- Append package name to `packages.txt` or Flathub ID to `flatpaks.txt`.
- Re-run `./install-packages.sh`.

<!--
## Components
| name | description |
| ----- | ----- |
| niri | window manager |
| noctalia | desktop shell |
| kitty | terminal |
| zsh | shell |
| rofi | launcher |
| nvim | editor |
| yazi | tui file manager |
| nautilus | gui file manager |
| p10k | prompt |
-->

## Keybinds

`Mod + /` to display hotkey overlay script.
