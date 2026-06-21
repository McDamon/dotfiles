{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
      };
    };
    desktopManager.gnome = {
      enable = true;
    };
    displayManager.gdm = {
      enable = true;
    };
  };

  programs.seahorse.enable = true;

  # Keep GNOME keyring available, but avoid PAM replacing SSH_AUTH_SOCK.
  security.pam.services.gdm.enableGnomeKeyring = false;

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.gtile
    gnome-tweaks
    nautilus
  ];
}
