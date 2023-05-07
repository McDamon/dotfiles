{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    yubikey-personalization
    yubikey-manager
    yubico-pam
    yubioath-flutter
  ];

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  security.pam.yubico = {
    enable = true;
    debug = true;
    mode = "challenge-response";
  };
}
