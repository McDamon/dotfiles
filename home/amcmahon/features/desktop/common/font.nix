{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    serif = {
      family = "Cantarell";
      package = pkgs.cantarell-fonts;
    };
    sansSerif = {
      family = "Cantarell";
      package = pkgs.cantarell-fonts;
    };
  };
}
