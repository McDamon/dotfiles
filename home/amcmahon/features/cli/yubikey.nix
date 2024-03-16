{ pkgs, ... }: {
  home.packages = with pkgs; [
    yubikey-personalization
    yubikey-manager
    yubico-piv-tool
  ];
}
