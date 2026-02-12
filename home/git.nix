{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "HAL";
        email = "68320771+HALQME@users.noreply.github.com";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICo87LAYNrYhv5xPCLFgZedT+hBWUBMJrG3WLW6GFnfM";
      };

      core = {
        excludesfile = "~/.gitignore_global";
        fsmonitor = true;
        untrackedCache = true;
        editor = "nvim";
      };

      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      init.defaultBranch = "main";
      
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      pull.rebase = true;
      
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      merge.conflictStyle = "zdiff3";
      help.autocorrect = "prompt";
      commit.verbose = true;
      commit.gpgSign = true;
      
      rerere = {
        enabled = true;
        autoupdate = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      filter.lfs = {
        required = true;
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
      };

      merge."our".driver = true;
      
      gpg.format = "ssh";
      gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      
      url."https://".insteadOf = "git://";
      
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

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
    };
  };

  # Global gitignore file
  home.file.".gitignore_global".text = ''
    # OS関連
    .DS_Store
    Thumbs.db

    # Python関連
    .venv/
    __pycache__/
    *.pyc
    *.pyo
    *.pyd

    # Node.js/JavaScript関連
    node_modules/
    bower_components/
    jspm_packages/

    # エディタ・IDE関連
    .idea/
    *.iml
    *.swp
    *.swo
    *.orig

    # ログ・キャッシュ・一時ファイル
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

    # PID・DB・バックアップ
    *.pid
    *.pid.lock
    *.pid.*
    *.pid.lock.*
    *.db
    *.sqlite
    *.sqlite3
    *.db-journal

    # アーカイブ・圧縮ファイル
    *.tgz
    *.gz
    *.zip
    *.tar
    *.rar
    *.7z
    *.tar.gz
    *.tar.bz2
    *.tar.xz

    # ビルド・カバレッジ・配布物
    dist/
    coverage/
    build/

    # その他
    .env
    .note.md
    .note.*.md
  '';
}
