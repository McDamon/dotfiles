{ pkgs, lib, config, ... }:
let
  ssh = "${pkgs.openssh}/bin/ssh";
in
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Andrew McMahon";
    userEmail = "andrew.p.mcmahon@gmail.com";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
