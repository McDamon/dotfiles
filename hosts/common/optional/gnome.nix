{ pkgs, lib, ... }: {
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

  programs.seahorse.enable = lib.mkForce false;

  security.pam.services.gdm.enableGnomeKeyring = lib.mkForce false;

  services.gnome.gnome-keyring.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.gtile
    gnome.gnome-tweaks
    gnome.nautilus
  ];
}
