# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# cd -> cd && ls -A
cd() {
  builtin cd "$@" && ls -A
}

alias clr='clear'
alias cls='clear'
alias ff='fastfetch'

alias la='ls -A' 

alias fd='fd -H' # include hidden files
alias fdd='fd -t d' # find directories only

alias rgl='rg -F -i' # no regex
alias rg='rg --smart-case'

alias kittyconf='code ~/.config/kitty/kitty.conf'
alias ffconf='code ~/.config/fastfetch/config.jsonc'

# boot windows via terminal
# alias windows='sudo grub2-reboot "Windows Boot Manager (on /dev/nvme0n1p1)" && reboot'

# replaces git for dotfile changes
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# for kansu
# alias kansu='python ~/projects/kansu/src/main.py'
# export PATH="$HOME/.local/share/zen:$PATH"

# for lyrcli
alias lyrcli='python3 ~/Projects/lyrcli/src/main.py'

export PATH="/home/yien/.local/bin:$PATH"
