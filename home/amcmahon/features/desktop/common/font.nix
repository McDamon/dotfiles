{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    serif = {
      family = "Source Serif 4";
      package = pkgs.source-serif;
    };
    sansSerif = {
      # GNOME 48+ default UI font (Inter-based). Adwaita ships no serif, so the
      # serif profile above pairs it with Source Serif 4.
      family = "Adwaita Sans";
      package = pkgs.adwaita-fonts;
    };
    emoji = {
      family = "Noto Color Emoji";
      package = pkgs.noto-fonts-color-emoji;
    };
  };
}
