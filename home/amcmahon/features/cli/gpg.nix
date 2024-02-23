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
      pinentryFlavor = "curses";
      enableSshSupport = true;
    };
  };
}
