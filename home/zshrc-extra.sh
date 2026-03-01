# Suffix aliases
alias -s {png,jpg,PNG,JPG,jpeg,JPEG}="imgcat"
alias -s {png,jpg,PNG,JPG,jpeg,JPEG}="imgcat"
alias -s {ts,js,tsx,jsx,html}="bun run"
alias -s py="python3"
alias -s python="python3"
alias -s sh="bash"
alias -s swift="swift"
alias -s md="glow -p"

# Post-command notification
notify() {
  if [ "$?" = 0 ]; then
    say -i -v 'Samantha' "The task was successful."
  else
    say -i -v 'Ava (Premium)' "The task failed."
  fi
}

# Minimize PDF file size using Ghostscript
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

# Credentials
source ~/.config/op/plugins.sh

# Tool-specific configurations
export GHQ_ROOT="$HOME/Repo"
export _ZO_DATA_DIR="${HOME}/.local/share"
export OLLAMA_FLASH_ATTENTION=1
export OLLAMA_CONTEXT_LENGTH=64000
export HOMEBREW_FORBIDDEN_FORMULAE="node python@3.13 python@3.14 python3 pip npm pnpm yarn"

# bun completions
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

# Powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
