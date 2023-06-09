{ config, lib, pkgs, ... }:

let
  cfg = config.programs.shellcolor;
  package = pkgs.shellcolord;

  renderSetting = key: value: ''
    ${key}=${value}
  '';
  renderSettings = settings:
    lib.concatStrings (lib.mapAttrsToList renderSetting settings);

in
{
  options.programs.shellcolor = {
    enable = lib.mkEnableOption "shellcolor";

    enableBashIntegration = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = ''
        Whether to enable Bash integration.
      '';
    };
    enableZshIntegration = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = ''
        Whether to enable Zsh integration.
      '';
    };
    enableFishIntegration = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = ''
        Whether to enable Fish integration.
      '';
    };

    settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      example = lib.literalExpression ''
        {
          base00 = "000000";
          base05 = "ffffff";
        }
      '';
      description = ''
        Options for shellcolord config file. Colors (without leading #)
        from base00 until base0F.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ package ];

    xdg.configFile."shellcolor.conf" = lib.mkIf (cfg.settings != { }) {
      text = renderSettings cfg.settings;
      onChange = ''
        timeout 1 ${package}/bin/shellcolor apply || true
      '';
    };

    programs.bash.initExtra = lib.mkIf cfg.enableBashIntegration
      (lib.mkBefore ''
        ${package}/bin/shellcolord $$ & disown
      '');

    programs.zsh.initExtra = lib.mkIf cfg.enableZshIntegration (lib.mkBefore ''
      ${package}/bin/shellcolord $$ & disown
    '');

    programs.fish.interactiveShellInit = lib.mkIf cfg.enableFishIntegration
      (lib.mkBefore ''
        ${package}/bin/shellcolord $fish_pid & disown
      '');
  };
}
