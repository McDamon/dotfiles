{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Andrew McMahon";
    userEmail = "andrew.p.mcmahon@gmail.com";
    lfs.enable = true;
    ignores = [
      ".direnv"
      "result"
    ];
  };
}
