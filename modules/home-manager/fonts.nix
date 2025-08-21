{
  lib,
  config,
  ...
}:
let
  mkFontOption = kind: {
    family = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "Family name for ${kind} font profile";
      example = "Fira Code";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = null;
      description = "Package for ${kind} font profile";
      example = "pkgs.fira-code";
    };
  };
  cfg = config.fontProfiles;
in
{
  options.fontProfiles = {
    enable = lib.mkEnableOption "Whether to enable font profiles";
    monospace = mkFontOption "monospace";
    serif = mkFontOption "serif";
    sansSerif = mkFontOption "sansSerif";
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;
    fonts.fontconfig.antialiasing = true;
    fonts.fontconfig.hinting = "slight";
    fonts.fontconfig = {
      defaultFonts = {
        serif = [
          cfg.serif.family
        ];
        sansSerif = [
          cfg.sansSerif.family
        ];
        monospace = [ 
          cfg.monospace.family 
        ];
      };
    };
    home.packages = [
      cfg.monospace.package
      cfg.serif.package
      cfg.sansSerif.package
    ];
  };
}
