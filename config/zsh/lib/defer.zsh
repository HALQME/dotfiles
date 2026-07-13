# Deferred callbacks are registered by plugins; only this runtime touches ZLE.
(( ${+_zsh_defer_first_input_callbacks} )) || typeset -ga _zsh_defer_first_input_callbacks=()
(( ${+_zsh_defer_first_command_callbacks} )) || typeset -ga _zsh_defer_first_command_callbacks=()

zsh_defer_run_callbacks() {
  local callback
  for callback in "$@"; do
    "$callback"
  done
}

zsh_defer_on_first_input() {
  _zsh_defer_first_input_callbacks+=("$1")
}

zsh_defer_on_first_command() {
  if (( ! ${+_zsh_defer_first_command_registered} )); then
    autoload -Uz add-zsh-hook
    add-zsh-hook preexec _zsh_defer_first_command
    typeset -g _zsh_defer_first_command_registered=1
  fi
  _zsh_defer_first_command_callbacks+=("$1")
}

_zsh_defer_first_input() {
  zle -A _zsh_defer_original_self_insert self-insert
  zsh_defer_run_callbacks "${_zsh_defer_first_input_callbacks[@]}"
  _zsh_defer_first_input_callbacks=()
  zle self-insert
}

_zsh_defer_first_command() {
  add-zsh-hook -d preexec _zsh_defer_first_command
  unset _zsh_defer_first_command_registered
  zsh_defer_run_callbacks "${_zsh_defer_first_command_callbacks[@]}"
  _zsh_defer_first_command_callbacks=()
}

if [[ -o interactive && -o zle && -z ${_zsh_defer_input_installed-} ]]; then
  zle -A self-insert _zsh_defer_original_self_insert
  zle -N self-insert _zsh_defer_first_input
  typeset -g _zsh_defer_input_installed=1
fi
