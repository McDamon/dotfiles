{ pkgs, ... }: {
  home.packages = with pkgs; [
    yubikey-personalization
    yubico-piv-tool
  ];
}
