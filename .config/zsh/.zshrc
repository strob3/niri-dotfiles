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

# boot windows
alias windows='sudo grub2-reboot "Windows Boot Manager (on /dev/nvme0n1p1)" && reboot'

# dotfiles
alias dot='cd ~/.dotfiles'

# neovim
alias nv='nvim'

# for kansu
alias kansu='python ~/Projects/kansu/src/cli/main.py'
export PATH="$HOME/.local/share/zen:$PATH"

# for lyrcli
alias lyrcli='python3 ~/Projects/lyrcli/src/main.py'

export PATH="/home/yien/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# go
export PATH="$PATH:/usr/local/go/bin"
# go binary
export PATH="$PATH:$(go env GOPATH)/bin"

# zoxide
eval "$(zoxide init zsh)"

# tok
for d in "/.local/bin" "/.bun/bin" "/.cargo/bin"; do
  [ -d "" ] && case "::" in *"::"*) ;; *) PATH=":" ;; esac
done
export PATH
