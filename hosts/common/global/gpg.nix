{ pkgs, ... }: {
  programs.ssh.startAgent = false;

  services.udev.packages = [ pkgs.yubikey-personalization ];

  services.pcscd.enable = true;

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  hardware.gpgSmartcards.enable = true;

  security.polkit.enable = true;
}
