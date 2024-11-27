{
  programs.keychain = {
    enable = true;
    enableBashIntegration = true;
    keys = [ "id_ed25519" ];
  };
}
