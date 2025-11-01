{ pkgs, lib, ... }:
{
  # Display manager configuration
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";  # Use KDE Breeze theme which properly shows keyboard layouts
    package = pkgs.kdePackages.sddm;  # Use KDE6 SDDM with Breeze theme
    settings = {
      General = {
        InputMethod = "";
      };
    };
  };

  # Keyboard layout configuration (X11 config is used by SDDM even in Wayland mode for keyboard layouts)
  # This does NOT start X11, it's just for keyboard configuration
  services.xserver = {
    enable = lib.mkForce true;  # Override the false setting in rocinante/default.nix
    xkb = {
      layout = "gb";
      variant = "intl";
      options = "";
    };
  };
  
  console.keyMap = "uk";

  # Enable KWallet for password/secret management (integrates better with SDDM)
  # Note: KWallet does NOT provide SSH agent functionality, so no conflict with 1Password SSH agent
  programs.kdeconnect.enable = true; # Brings in KDE frameworks
  
  # Enable kwallet unlock at login via PAM
  security.pam.services.sddm.enableKwallet = true;
  
  # Hyprland program
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # XDG portal configuration
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-hyprland 
      pkgs.xdg-desktop-portal-gtk 
    ];
    configPackages = [ pkgs.hyprland ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
