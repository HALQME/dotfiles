# A compact two-line prompt: location and Git branch above, status below.
def _nu_prompt_path [] {
  match (do -i { $env.PWD | path relative-to $nu.home-dir }) {
    null => $env.PWD
    '' => '~'
    $relative_pwd => ([~ $relative_pwd] | path join)
  }
}

def _nu_prompt_git_branch [] {
  let result = (^git branch --show-current | complete)
  if $result.exit_code != 0 {
    return ''
  }

  let branch = ($result.stdout | str trim)
  if ($branch | is-empty) {
    return ''
  }

  $" (ansi dark_gray)git:(ansi yellow)($branch)(ansi reset)"
}

$env.PROMPT_COMMAND = {||
  let path = (_nu_prompt_path)
  $"\n(ansi cyan_bold)($path)(ansi reset)(_nu_prompt_git_branch)\n"
}

$env.PROMPT_COMMAND_RIGHT = {|| '' }
$env.PROMPT_INDICATOR = {||
  if ($env.LAST_EXIT_CODE? | default 0) == 0 {
    $"(ansi green_bold)nu❯(ansi reset) "
  } else {
    $"(ansi red_bold)nu❯(ansi reset) "
  }
}
