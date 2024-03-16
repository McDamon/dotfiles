{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Andrew McMahon";
    userEmail = "andrew.p.mcmahon@gmail.com";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
      commit.gpgSign = true;
      user.signing.key = "AD4C8118B97C38DC6647F7D34EADEA4DCA9F786A";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
