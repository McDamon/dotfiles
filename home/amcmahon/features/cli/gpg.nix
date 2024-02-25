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
      pinentryFlavor = "gtk2";
      enableSshSupport = true;
    };
  };
}
