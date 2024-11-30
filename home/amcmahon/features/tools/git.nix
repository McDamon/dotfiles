{ pkgs, lib, ... }:
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
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHJYM90ek9Pv+oIAldaLoNn9YWOq3/jPNJiuaYtvH0N";
      };
    };
  };
}
