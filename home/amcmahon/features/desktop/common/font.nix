{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font Mono";
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
    };
    regular = {
      family = "Ubuntu";
      package = pkgs.ubuntu_font_family;
    };
  };
}
