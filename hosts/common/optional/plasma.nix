{ ... }: {

  services.xserver.enable = true;
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = false;
  };
}
