{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "gb";
        variant = "intl";
      };
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "Elegant";
      extraPackages = with pkgs;[
        elegant-sddm
      ];
    };
  };
  environment.systemPackages = [
    (pkgs.elegant-sddm.override {
      themeConfig.General = {
        background = "${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath}";
      };
    })
  ];
}
