{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
    };
    desktopManager.plasma6 = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [ qt5.qtwayland qt6.qtwayland ];
}
