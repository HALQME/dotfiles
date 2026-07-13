{...}: let
  gitEmail = "68320771+HALQME@users.noreply.github.com";
in {
  programs.git.enable = true;
  programs.git.settings = {
    user = {
      name = "HAL";
      email = gitEmail;
      useConfigOnly = true;
    };

    init.defaultBranch = "main";

    core = {
      fsmonitor = true;
      excludesfile = "~/.gitignore_global";
      untrackedCache = true;
      pager = "delta";
    };

    branch.sort = "-committerdate";
    tag.sort = "version:refname";

    diff = {
      algorithm = "histogram";
      colorMoved = "plain";
      mnemonicPrefix = true;
      renames = true;
    };

    merge = {
      conflictStyle = "zdiff3";
      "our".driver = true;
    };

    push = {
      default = "simple";
      autoSetupRemote = true;
      followTags = true;
    };

    fetch = {
      prune = true;
      pruneTags = true;
      all = true;
    };

    commit.verbose = true;

    interactive.diffFilter = "delta --color-only";
    pager.blame = "delta";

    rebase = {
      autoSquash = true;
      autoStash = true;
      updateRefs = true;
    };

    help.autocorrect = "prompt";

    rerere = {
      enabled = true;
      autoupdate = true;
    };

    filter.lfs = {
      required = true;
      clean = "git-lfs clean -- %f";
      smudge = "git-lfs smudge -- %f";
      process = "git-lfs filter-process";
    };

    url."https://".insteadOf = "git://";

    alias = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit -m";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
    };
  };
}
