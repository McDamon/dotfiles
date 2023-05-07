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
      user.signing.key = "42D7BE4E099E7BE84FAF8CB7847252D89CADA3D8";
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
