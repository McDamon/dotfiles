{ pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [ qt6.qtwayland ];

  services.gnome.gnome-keyring.enable = lib.mkForce false;
}
