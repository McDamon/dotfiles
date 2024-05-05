{ pkgs, lib, ... }:
{
  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = lib.mkForce pkgs.pinentry-gnome3;
      enableSshSupport = true;
      enableExtraSocket = true;
      enableZshIntegration = true;
    };
  };
}
