{pkgs, ...}: {
  services.udev.packages = [pkgs.yubikey-personalization];

  services.pcscd.enable = true;

  hardware.gpgSmartcards.enable = true;
}
