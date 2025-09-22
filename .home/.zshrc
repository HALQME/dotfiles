# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# ==============================================================================
# Shell Configuration
# ==============================================================================

## Options
# Enable colors
autoload -Uz colors && colors
# Set keybindings to Emacs mode
bindkey -e

# Various Zsh options for a better user experience

setopt \
  PRINT_EIGHT_BIT \
  INTERACTIVE_COMMENTS \
  AUTO_CD \
  EXTENDED_HISTORY \
  RM_STAR_SILENT \
  SHARE_HISTORY \
  HIST_IGNORE_ALL_DUPS \
  HIST_IGNORE_SPACE \
  HIST_REDUCE_BLANKS


# ==============================================================================
# Credentials
# ==============================================================================
source ~/.config/op/plugins.sh

# ==============================================================================
# Aliases
# ==============================================================================

## Global Aliases (can be used anywhere in a command)
alias -g C=" | tee >(pbcopy)"
alias -g G=" | grep"
alias -g L=" | less"
alias -g N=" ; notify"
alias -g P=" | pbpaste"
alias -g Cloud="$HOME/Library/CloudStorage/"
alias -g iCloud="$HOME/Library/Mobile\ Documents/com~apple~CloudDocs/"

## Suffix Aliases (run a command based on file extension)
alias -s {png,jpg,PNG,JPG,jpeg,JPEG}="imgcat"
alias -s py="python3"
alias -s sh="bash"
alias -s swift="swift"

## Regular Aliases
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ~="cd ~"
alias c="clear"
alias ls="lsd"
alias ll="lsd -la"
alias lg="lazygit"
alias d="docker"
alias mp='multipass'
alias edit="vim"

# Overwrite built-ins with safer/better versions
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir="mkdir -p"
alias history='history -t "%F %T"'

# System / Utility aliases
alias df="df -h"
alias du="du -h"
alias free="free -h" # Note: `free` is not native to macOS
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias calc="bc -l"
alias datestamp="date +%Y%m%d%H%M%S"
alias ipinfo="curl ipinfo.io"
alias weather="curl wttr.in"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias untar="tar -zxvf"
alias python="python3"

# App/Tool specific aliases
alias brew-backup="brew bundle dump --force --file $HOME/.dotfiles/.home/Brewfile --describe"
alias gptk="gameportingtoolkit-no-hud ~/$MY_GAME_PREFIX"
alias pdftohtml='pdftohtml -enc UTF-8 -noframes'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias trans='trans -b'
alias transe2j='\trans en:ja -b'
alias transj2e='\trans ja:en -b'
alias yt-dlp-f="yt-dlp --no-check-certificate"
alias zj="zellij attach default || zellij --session default"

# ==============================================================================
# Functions
# ==============================================================================

## Post-command notification
notify() {
  if [ "$?" = 0 ]; then
    say -i -v 'Samantha' "The task was successful."
  else
    say -i -v 'Ava (Premium)' "The task failed."
  fi
}

## Minimize PDF file size using Ghostscript
pdfmin() {
  local cnt=0
  for i in "$@"; do
    gs -sDEVICE=pdfwrite \
      -dCompatibilityLevel=1.4 \
      -dPDFSETTINGS=/ebook \
      -dNOPAUSE -dQUIET -dBATCH \
      -sOutputFile="${i%%.*}.min.pdf" "${i}" &
    # Wait every 4 jobs to avoid overwhelming the system
    (( (cnt += 1) % 4 == 0 )) && wait
  done
  wait && return 0
}

## The Fuck: command-line corrector
fuck() {
  TF_PYTHONIOENCODING=$PYTHONIOENCODING;
  export TF_SHELL=zsh;
  export TF_ALIAS=fuck;
  TF_SHELL_ALIASES=$(alias);
  export TF_SHELL_ALIASES;
  TF_HISTORY="$(fc -ln -10)";
  export TF_HISTORY;
  export PYTHONIOENCODING=utf-8;
  TF_CMD=$(
    thefuck THEFUCK_ARGUMENT_PLACEHOLDER "$@"
  ) && eval "$TF_CMD";
  unset TF_HISTORY;
  export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
  test -n "$TF_CMD" && print -s "$TF_CMD"
}

# ==============================================================================
# Environment Variables & PATH
# ==============================================================================
# Using the `path` array is the recommended Zsh way to manage your PATH.
# `typeset -U` ensures that all elements are unique, preventing duplicates.
typeset -U path

# Define tool-specific variables
export VOLTA_HOME="$HOME/.volta"
export GO_HOME="$HOME/.go"
export SWIFTLY_HOME_DIR="${HOME}/.swiftly"
export DOTNET_ROOT="/usr/local/share/dotnet"
export MODULAR_HOME="$HOME/.modular"
export BAT_THEME="OneHalfDark"
export MY_GAME_PREFIX=".wine" # For Game Porting Toolkit

# Prepend directories to PATH. Order matters; first entry is checked first.
path=(
  # Development Tools & SDKs
  "$MODULAR_HOME/pkg/packages.modular.com_mojo/bin" # Modular Mojo
  "$VOLTA_HOME/bin" # Volta
  "$GO_HOME/bin" # Go
  "$SWIFTLY_HOME_DIR/bin" # Swift
  "$HOME/.ghcup/bin" # Haskell
  "$HOME/.progate/bin" # Progate Path
  "$HOME/.lmstudio/bin" # LM Studio CLI

  # Homebrew-installed tools
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "/opt/homebrew/opt/llvm/bin"
  "/opt/homebrew/opt/rustup/bin"
  "/opt/homebrew/opt/ruby/bin"

  # Keep existing system paths
  $path
)

# Append directories to PATH
path+=(
  "$DOTNET_ROOT"
)

# Compiler Flags for Homebrew LLVM
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"

# The `path` array is automatically tied to the $PATH variable.
export PATH

# ==============================================================================
# Initializations (should be at the end)
# ==============================================================================

## Starship Prompt
eval "$(starship init zsh)"

## Zsh Syntax Highlighting
ZSH_SYNTAX_HIGHLIGHTING_FILE="/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "$ZSH_SYNTAX_HIGHLIGHTING_FILE" ]]; then
  source "$ZSH_SYNTAX_HIGHLIGHTING_FILE"
fi

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
