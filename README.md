# niri-dotfiles

Personal dotfiles built around niri and noctalia.

## Setup
```bash
git clone https://github.com/strob3/niri-dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# install core packages & flatpaks (optional)
./install-packages.sh

# apply dotfiles (symlinks configs and backs up conflicting files)
./install-dotfiles.sh
```

## Usage 

### 1. Editing Configs
Configs in `~/.config/` are symlinks to `~/.dotfiles/.config/`.
```bash
nvim ~/.config/niri/config.kdl
# changes are tracked in ~/.dotfiles
```

### 2. Tracking New Configs
```bash
# move folder into dotfiles
mv ~/.config/foo ~/.dotfiles/.config/

# add "foo" to CONFIG_DIRS array inside install-dotfiles.sh
# symlink it
cd ~/.dotfiles
./install-dotfiles.sh
```

### 3. Adding Packages or Flatpaks
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


