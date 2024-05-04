{ inputs, pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  environment.systemPackages = with pkgs; [ qt6.qtwayland libsecret ];

  services.gnome.gnome-keyring.enable = lib.mkForce true;
  
  programs.seahorse.enable = true;

  security.pam.services.gdm.enableGnomeKeyring = true; 
}
