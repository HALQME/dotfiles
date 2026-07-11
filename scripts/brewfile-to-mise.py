#!/usr/bin/env python3
"""Regenerate mise/config.macos.toml from Brewfile + static brew formulae."""

from __future__ import annotations

import re
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
BREWFILE = REPO_ROOT / "config/homebrew/Brewfile"
OUTPUT = REPO_ROOT / "mise/config.macos.toml"

# Hand-maintained CLI formulae (not in Brewfile).
FORMULAE = [
    "act",
    "age",
    "aria2",
    "bottom",
    "bun",
    "crystal",
    "crystalline",
    "deno",
    "dust",
    "eza",
    "fd",
    "ffmpeg",
    "gat",
    "gh",
    "ghq",
    "git-delta",
    "go",
    "htop",
    "jq",
    "just",
    "jujutsu",
    "lazygit",
    "neovim",
    "nim",
    "pnpm",
    "powerlevel10k",
    "ripgrep",
    "rust",
    "tmux",
    "yazi",
    "zoxide",
    "zsh-fast-syntax-highlighting",
    "fzf",
]

HEADER = """# macOS-specific bootstrap (auto-loaded via settings.auto_env)
# Regenerate: python3 scripts/brewfile-to-mise.py

[bootstrap.packages]
"""


def parse_brewfile(path: Path) -> list[str]:
    casks: list[str] = []
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        match = re.match(r'(brew|cask)\s+"([^"]+)"', line)
        if not match:
            continue
        kind, name = match.groups()
        if kind == "brew":
            continue  # formulae are managed in FORMULAE above
        casks.append(f'"brew-cask:{name}" = "latest"')
    return casks


def main() -> None:
    formulae = [f'"brew:{name}" = "latest"' for name in FORMULAE]
    casks = parse_brewfile(BREWFILE)
    lines = [HEADER.rstrip(), *formulae, "", "# --- Brewfile casks ---", *casks, ""]
    OUTPUT.write_text("\n".join(lines))
    print(f"Wrote {len(formulae)} formulae + {len(casks)} casks to {OUTPUT}")


if __name__ == "__main__":
    main()
