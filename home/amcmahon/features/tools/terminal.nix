{ pkgs, ... }: {
  programs.bash.enable = true;
  programs.fzf.enable = true;
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
