{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    serif = {
      family = "EB Garamond";
      package = pkgs.eb-garamond;
    };
    sansSerif = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
