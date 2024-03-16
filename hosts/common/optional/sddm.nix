{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "gb";
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "Elegant";
        extraPackages = with pkgs;[
          elegant-sddm
        ];
      };
    };
  };

  environment.systemPackages = [
    pkgs.elegant-sddm
  ];
}
