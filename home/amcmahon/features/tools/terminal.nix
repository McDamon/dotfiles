{ pkgs, config, ... }:
let
  onePassPath = "${config.home.homeDirectory}/.1password/agent.sock";
in
{
  programs.bash.enable = true;
  systemd.user.sessionVariables.SSH_AUTH_SOCK = onePassPath;
  programs.fzf.enable = true;
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
