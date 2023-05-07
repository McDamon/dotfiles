{ config, pkgs, lib, inputs, ... }:
{
  sops.secrets.spotify-password = {
    sopsFile = ../secrets.yaml;
  };

  services.spotifyd = {
    enable = true;
    settings =
      {
        global = {
          username = "Maypolen";
          password = config.sops.secrets.spotify-password.path;
        };
      };
  };
}
