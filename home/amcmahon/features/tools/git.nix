{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    ignores = [
      ".direnv"
      "result"
      "*~"
      "*.swp"
      ".DS_Store"
    ];

    settings = {
      user = {
        name = "Andrew McMahon";
        email = "andrew.p.mcmahon@gmail.com";
      };

      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        rebase.autoStash = true;

        # GPG/SSH signing with 1Password
        gpg.format = "ssh";
        "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        commit.gpgsign = true;
        user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJiE8XwKjtHZ7qaus5y4CbQn7+lsi3F5bI0wrCgWl/14";

        # Better diffs
        diff.algorithm = "histogram";
        merge.conflictStyle = "zdiff3";

        # Performance
        core.preloadindex = true;
        core.fscache = true;
        gc.auto = 256;
      };

      aliases = {
        # Status & info
        s = "status -sb";
        st = "status";

        # Commits
        c = "commit";
        cm = "commit -m";
        ca = "commit --amend";
        can = "commit --amend --no-edit";

        # Branches
        b = "branch";
        ba = "branch -a";
        bd = "branch -d";

        # Checkout
        co = "checkout";
        cob = "checkout -b";

        # Logs
        l = "log --oneline --graph --decorate";
        ll = "log --graph --pretty=format:'%C(yellow)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";

        # Diffs
        d = "diff";
        ds = "diff --staged";

        # Stash
        ss = "stash save";
        sp = "stash pop";
        sl = "stash list";

        # Pull/Push
        pl = "pull";
        ps = "push";
        psu = "push -u origin HEAD";

        # Misc
        unstage = "reset HEAD --";
        uncommit = "reset --soft HEAD~1";
        aliases = "config --get-regexp alias";
      };
    };
  };
}
