{ outputs, lib, ... }:
{
  programs.keychain = {
    enable = true;
    keys = [ "~/.ssh/id_ed25519" ];
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
