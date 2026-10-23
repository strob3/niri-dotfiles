if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f "${ZDOTDIR:-$HOME}/.p10k.zsh" ]] || source "${ZDOTDIR:-$HOME}/.p10k.zsh"

# plugins 
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# navigation 
cd() {
  builtin cd "$@" && eza -a --icons=auto --group-directories-first
}
alias dot='cd ~/.dotfiles'
alias ..='cd ..'
alias ...='cd ../..'

# ls & terminal 
if command -v eza &>/dev/null; then
  alias ls='eza --icons=auto --group-directories-first'
  alias l='eza -lh --icons=auto --group-directories-first'
  alias la='eza -a --icons=auto --group-directories-first'
  alias ll='eza -lha --icons=auto --group-directories-first --git'
  alias lt='eza --tree --level=2 --icons=auto'
  alias lta='eza --tree --level=2 -a --icons=auto'
else
  alias ls='ls --color=auto'
  alias la='ls -A'
  alias ll='ls -la'
fi
alias clr='clear'
alias cls='clear'
alias ff='fastfetch'

# search (ripgrep & fd) 
alias rg='rg --smart-case'
alias rgl='rg -F -i'       # literal string, case insensitive
alias fd='fd -H'           # include hidden files
alias fdd='fd -t d'        # directories only

# clipboard (wayland) 
alias c='wl-copy'
alias p='wl-paste'

# editor & quick edits 
alias nv='nvim'
alias kittyconf='nvim ~/.config/kitty/kitty.conf'
alias ffconf='nvim ~/.config/fastfetch/config.jsonc'
alias zshconf='nvim ${ZDOTDIR:-$HOME}/.zshrc'

# git 
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'

# safety prompts
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'          # if deleting >3 files or recursive
  
# quick inspection
alias myip='curl -s ifconfig.me'
alias ports='ss -tulpn'

# environment & paths 
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:${GOPATH:-$HOME/go}/bin"

# zoxide
eval "$(zoxide init zsh)"

# extra user bin paths
for d in "$HOME/.local/bin" "$HOME/.bun/bin" "$HOME/.cargo/bin"; do
  [[ -d "$d" ]] && [[ ":$PATH:" != *":$d:"* ]] && PATH="$d:$PATH"
done
export PATH

[[ -f "${ZDOTDIR:-$HOME}/.zshrc.local" ]] && source "${ZDOTDIR:-$HOME}/.zshrc.local"
