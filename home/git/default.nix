{
  # ============================================================================
  # GIT CONFIGURATION
  # ============================================================================

  programs.git = {
    enable = true;

    # ========================================================================
    # USER SETTINGS
    # ========================================================================
    settings = {
      user = {
        name = "HAL";
        email = "68320771+HALQME@users.noreply.github.com";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICo87LAYNrYhv5xPCLFgZedT+hBWUBMJrG3WLW6GFnfM";
      };

      # ====================================================================
      # CORE SETTINGS
      # ====================================================================
      core = {
        excludesfile = "~/.gitignore_global";
        fsmonitor = true;                    # Use filesystem monitor for better performance
        untrackedCache = true;               # Cache untracked files list
        editor = "nvim";
      };

      # ====================================================================
      # BRANCH & TAG CONFIGURATION
      # ====================================================================
      branch.sort = "-committerdate";        # Sort branches by commit date (newest first)
      tag.sort = "version:refname";          # Sort tags by version
      init.defaultBranch = "main";

      # ====================================================================
      # DIFF & MERGE SETTINGS
      # ====================================================================
      diff = {
        algorithm = "histogram";             # Better diff algorithm
        colorMoved = "plain";                # Highlight moved code
        mnemonicPrefix = true;               # Use mnemonic prefixes (a/b -> c/i for copy/index)
        renames = true;                      # Detect renames
      };

      merge.conflictStyle = "zdiff3";        # Better 3-way merge visualization

      # ====================================================================
      # PUSH & PULL SETTINGS
      # ====================================================================
      push = {
        default = "simple";                  # Push only current branch
        autoSetupRemote = true;              # Automatically set up tracking branch
        followTags = true;                   # Push tags automatically
      };

      pull.rebase = true;                    # Use rebase instead of merge when pulling

      # ====================================================================
      # FETCH SETTINGS
      # ====================================================================
      fetch = {
        prune = true;                        # Remove deleted remote branches
        pruneTags = true;                    # Remove deleted remote tags
        all = true;                          # Fetch all remotes
      };

      # ====================================================================
      # COMMIT & REBASE SETTINGS
      # ====================================================================
      commit = {
        verbose = true;                      # Show diff in commit editor
        gpgSign = true;                      # Sign commits by default
      };

      rebase = {
        autoSquash = true;                   # Auto-squash marked commits
        autoStash = true;                    # Stash changes before rebase
        updateRefs = true;                   # Update branches that point to rebased commits
      };

      # ====================================================================
      # HELP & ERROR RECOVERY
      # ====================================================================
      help.autocorrect = "prompt";           # Suggest corrections for typos
      
      rerere = {
        enabled = true;                      # Reuse recorded resolution (git rerere)
        autoupdate = true;                   # Auto-update rerere database
      };

      # ====================================================================
      # GPG SIGNING (using SSH via 1Password)
      # ====================================================================
      gpg.format = "ssh";
      gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";

      # ====================================================================
      # GIT LFS (Large File Storage)
      # ====================================================================
      filter.lfs = {
        required = true;
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
      };

      # ====================================================================
      # URL REWRITES
      # ====================================================================
      url."https://".insteadOf = "git://";  # Use HTTPS instead of git://

      # ====================================================================
      # MERGE DRIVERS
      # ====================================================================
      merge."our".driver = true;

      # ====================================================================
      # COMMAND ALIASES
      # ====================================================================
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        visual = "!gitk";
      };
    };
  };

  # ============================================================================
  # DELTA - Syntax-Highlighting Pager for Diffs
  # ============================================================================
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;                      # Allow navigation in diffs
      line-numbers = true;                  # Show line numbers
      side-by-side = true;                  # Show diffs side-by-side
    };
  };

  # ============================================================================
  # GLOBAL GITIGNORE
  # ============================================================================
  home.file.".gitignore_global".text = ''
    # ========================================================================
    # OS-RELATED FILES
    # ========================================================================
    .DS_Store
    Thumbs.db

    # ========================================================================
    # PYTHON
    # ========================================================================
    .venv/
    venv/
    env/
    __pycache__/
    *.pyc
    *.pyo
    *.pyd
    .pytest_cache/
    .coverage
    htmlcov/

    # ========================================================================
    # NODE.JS / JAVASCRIPT
    # ========================================================================
    node_modules/
    bower_components/
    jspm_packages/
    dist/
    .next/
    .nuxt/

    # ========================================================================
    # EDITOR & IDE
    # ========================================================================
    .idea/
    .vscode/
    *.iml
    *.swp
    *.swo
    *.orig
    *~
    .DS_Store
    .env.local

    # ========================================================================
    # LOGS, CACHE & TEMPORARY FILES
    # ========================================================================
    *.log
    *.log.*
    *.cache
    *.tmp
    tmp/
    temp/
    cache/
    logs/
    *.bak
    *.out

    # ========================================================================
    # DATABASE & PERSISTENCE
    # ========================================================================
    *.pid
    *.pid.lock
    *.pid.*
    *.db
    *.sqlite
    *.sqlite3
    *.db-journal

    # ========================================================================
    # ARCHIVES & COMPRESSED FILES
    # ========================================================================
    *.tgz
    *.gz
    *.zip
    *.tar
    *.rar
    *.7z
    *.tar.gz
    *.tar.bz2
    *.tar.xz

    # ========================================================================
    # BUILD & DISTRIBUTION
    # ========================================================================
    dist/
    build/
    coverage/
    target/
    out/

    # ========================================================================
    # ENVIRONMENT & SECRETS
    # ========================================================================
    .env
    .env.local
    .env.*.local
    .note.md
    .note.*.md
  '';
}