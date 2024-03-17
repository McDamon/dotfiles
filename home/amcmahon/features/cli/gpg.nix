{ pkgs, lib, ... }:
{
  programs = {
    gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = lib.mkForce pkgs.pinentry-qt;
      enableSshSupport = true;
    };
  };
}
