{ pkgs, config, ... }:
let
  onePassPath = "${config.home.homeDirectory}/.1password/agent.sock";
in
{
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    export SSH_AUTH_SOCK="${onePassPath}"
  '';

  xdg.configFile."environment.d/10-ssh-auth-sock.conf".text = ''
    SSH_AUTH_SOCK=${onePassPath}
  '';

  # Ensure systemd user units and HM-managed sessions point to 1Password's SSH agent.
  home.sessionVariables.SSH_AUTH_SOCK = onePassPath;
  systemd.user.sessionVariables.SSH_AUTH_SOCK = onePassPath;
  programs.fzf.enable = true;
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
