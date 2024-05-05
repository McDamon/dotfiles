{ inputs, pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  environment.systemPackages = with pkgs; [ qt6.qtwayland ];

  services.gnome.gnome-keyring.enable = lib.mkForce false;
}
