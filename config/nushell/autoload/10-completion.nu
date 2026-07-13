# Carapace adds completion metadata for external commands. Keeping its closure
# here avoids loading it for non-interactive `nu -c` invocations.
let carapace_completer = {|spans|
  carapace $spans.0 nushell ...$spans | from json
}

$env.config.completions = (
  $env.config.completions
  | upsert algorithm "fuzzy"
  | upsert quick true
  | upsert partial true
  | upsert external {
    enable: true
    max_results: 100
    completer: $carapace_completer
  }
)
