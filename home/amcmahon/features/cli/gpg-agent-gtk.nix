{ pkgs, lib, ... }:
{
  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = lib.mkForce pkgs.pinentry-gtk2;
      enableSshSupport = true;
    };
  };
}
