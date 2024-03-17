{ pkgs, ... }: {
  home.packages = with pkgs; [
    faf-client
    protontricks
  ];
}
