{ pkgs, lib, ... }:
{
  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = lib.mkForce pkgs.pinentry-qt;
      enableSshSupport = true;
      enableExtraSocket = true;
      enableZshIntegration = true;
    };
  };
}
