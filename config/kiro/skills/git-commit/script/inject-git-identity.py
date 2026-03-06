import json
import sys

event = json.load(sys.stdin)
cmd = event.get("tool_input", {}).get("command", "")

if "git commit" in cmd and "GIT_AUTHOR_NAME" not in cmd:
    print("Please prepend agent identity: GIT_AUTHOR_NAME='Kiro CLI' GIT_AUTHOR_EMAIL='kiro-cli@dev.local' GIT_COMMITTER_NAME='Kiro CLI' GIT_COMMITTER_EMAIL='kiro-cli@dev.local'", file=sys.stderr)
    sys.exit(2)