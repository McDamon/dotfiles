{ pkgs, lib, ... }:
{
  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = lib.mkForce pkgs.pinentry-qt;
      enableSshSupport = true;
    };
  };
}
