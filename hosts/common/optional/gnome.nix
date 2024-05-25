{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "gb";
        variant = "intl";
      };
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  programs.seahorse.enable = true;

  security.pam.services.gdm.enableGnomeKeyring = true;

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.gtile
    gnome.gnome-tweaks
    gnome.nautilus
  ];
}
