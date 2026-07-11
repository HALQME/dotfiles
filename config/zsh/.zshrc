# Managed by mise dotfiles — see ~/.dotfiles/mise/config.toml

# Some prompt/completion snippets assume these exist and trip over unset vars.
export SSH_CONNECTION="${SSH_CONNECTION-}"
export SSH_CLIENT="${SSH_CLIENT-}"
export SSH_TTY="${SSH_TTY-}"

# Tool paths (mise handles most tools; these are for optional/manual installs)
path=(
  "$HOME/.local/bin"
  "$HOME/.modular/pkg/packages.modular.com_mojo/bin"
  "$HOME/.ghcup/bin"
  "$HOME/.go/bin"
  "$HOME/.pnpm/bin"
  "$HOME/.bun/bin"
  "$HOME/.deno/bin"
  "$HOME/.moon/bin"
  "$HOME/.lmstudio/bin"
  $path
)
typeset -U path
export PATH

# Zsh options
setopt AUTO_PUSHD
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt PRINT_EIGHT_BIT
setopt PUSHD_IGNORE_DUPS
setopt RM_STAR_SILENT

HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# Aliases
alias -g G='| rg'
alias -g L='| less -R'
alias -g C='| tee >(pbcopy)'
alias -g P='| pbpaste'
alias -g Cloud="$HOME/Library/CloudStorage/"

alias ..='cd ..'
alias ..2='cd ../..'
alias ~='cd ~'

alias c='clear'
alias ls='eza'
alias ll='eza -la'
alias lg='lazygit'
alias grep='rg'
alias nd='mise exec -- $SHELL'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias less='less -R'
alias history='history -t "%F %T"'
alias untar='tar -zxvf'

alias d='docker'
alias dc='docker compose'
alias orb='TERM=xterm-256color orb'
alias df='df -h'
alias du='du -h'
alias calc='bc -l'
alias datestamp='date +%Y%m%d%H%M%S'
alias now='date +%Y/%m/%d\ %H:%M\;%S'
alias iso='date +%Y-%m-%dT%H:%M:%S%z'
alias ipinfo='curl ipinfo.io'
alias weather='curl wttr.in'
alias port='lsof -i'
alias repo='cd $(ghq list --full-path | fzf)'

alias agec='age -R ~/.config/age/recipient.txt'
alias aged='age --decrypt -i ~/.config/age/identity.age'
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'

alias -s {png,jpg,PNG,JPG,jpeg,JPEG}='gat'
alias -s {ts,js,tsx,jsx,html,md}='bun run'
alias -s py='python3'
alias -s python='python3'
alias -s sh='bash'
alias -s swift='swift'
alias -s cr='crystal'

mkcd() {
  mkdir --parents "$1" && cd "$1"
}

if [[ -o interactive ]]; then
  if [ -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
  elif [ -f /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
  fi
fi

if [[ -o interactive ]]; then
  if [ -f /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]; then
    source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  elif [ -f /usr/local/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]; then
    source /usr/local/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  fi
fi

if [[ -o interactive ]] && [[ -o zle ]] && [ -f "$HOME/.config/zsh/.p10k.zsh" ]; then
  source "$HOME/.config/zsh/.p10k.zsh"
fi

if [[ -o interactive ]] && [ -s "$HOME/.bun/_bun" ]; then
  source "$HOME/.bun/_bun"
fi

if [ -s "$HOME/.vite-plus/env" ]; then
  source "$HOME/.vite-plus/env"
fi

# home-manager generated: direnv, nix-index, Nix PATH (darwin)
[ -f "$HOME/.config/zsh/nix-env.zsh" ] && source "$HOME/.config/zsh/nix-env.zsh"
