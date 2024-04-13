{ pkgs, ... }: {
  programs.ssh.startAgent = false;

  services.udev.packages = [ pkgs.yubikey-personalization ];

  services.pcscd.enable = true;

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  hardware.gpgSmartcards.enable = true;

  environment.systemPackages = [ pkgs.pcsclite ];

  security.polkit.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.debian.pcsc-lite.access_card" &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
    polkit.addRule(function(action, subject) {
        if (action.id == "org.debian.pcsc-lite.access_pcsc" &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
  '';
}
