{
  lib,
  config,
  ...
}:
let
  mkFontOption = kind: {
    family = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Family name for ${kind} font profile";
      example = "Fira Code";
    };
    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
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
    emoji = mkFontOption "emoji";
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.monospace.family != null && cfg.monospace.package != null;
        message = "fontProfiles.monospace.family and fontProfiles.monospace.package must be set when fontProfiles.enable = true";
      }
      {
        assertion = cfg.serif.family != null && cfg.serif.package != null;
        message = "fontProfiles.serif.family and fontProfiles.serif.package must be set when fontProfiles.enable = true";
      }
      {
        assertion = cfg.sansSerif.family != null && cfg.sansSerif.package != null;
        message = "fontProfiles.sansSerif.family and fontProfiles.sansSerif.package must be set when fontProfiles.enable = true";
      }
    ];

    fonts.fontconfig.enable = true;
    fonts.fontconfig.antialiasing = true;
    fonts.fontconfig.hinting = "slight";
    fonts.fontconfig = {
      defaultFonts =
        let
          # Append the emoji family to every text chain so emoji render inline
          # regardless of the surrounding font, and degrade gracefully.
          emoji = lib.optional (cfg.emoji.family != null) cfg.emoji.family;
        in
        {
          serif = [ cfg.serif.family ] ++ emoji;
          sansSerif = [ cfg.sansSerif.family ] ++ emoji;
          monospace = [ cfg.monospace.family ] ++ emoji;
          emoji = lib.mkIf (cfg.emoji.family != null) [ cfg.emoji.family ];
        };
    };
    home.packages = [
      cfg.monospace.package
      cfg.serif.package
      cfg.sansSerif.package
    ]
    ++ lib.optional (cfg.emoji.package != null) cfg.emoji.package;
  };
}
