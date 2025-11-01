{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [
      ".direnv"
      "result"
    ];
    settings = {
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
        name = "Andrew McMahon";
        email = "andrew.p.mcmahon@gmail.com";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJiE8XwKjtHZ7qaus5y4CbQn7+lsi3F5bI0wrCgWl/14";
      };
    };
  };
}
