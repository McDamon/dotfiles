{ lib, config, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.monitors = mkOption {
    type = types.listOf (
      types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          primary = mkOption {
            type = types.bool;
            default = false;
          };
          width = mkOption {
            type = types.int;
            example = 1920;
          };
          height = mkOption {
            type = types.int;
            example = 1080;
          };
          refreshRate = mkOption {
            type = types.int;
            default = 60;
          };
          position = mkOption {
            type = types.str;
            default = "auto";
          };
          scale = mkOption {
            type = types.str;
            default = "1";
          };
          enabled = mkOption {
            type = types.bool;
            default = true;
          };
          workspace = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
          hdr = mkOption {
            type = types.bool;
            default = false;
            description = "Enable HDR on this monitor. Requires compatible hardware and display.";
          };
        };
      }
    );
    default = [ ];
  };
  config = {
    assertions = [
      {
        assertion =
          ((lib.length config.monitors) != 0)
          -> ((lib.length (lib.filter (m: m.primary) config.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
      }
      {
        assertion = lib.all (m: m.width > 0) config.monitors;
        message = "Monitor width must be greater than 0.";
      }
      {
        assertion = lib.all (m: m.height > 0) config.monitors;
        message = "Monitor height must be greater than 0.";
      }
      {
        assertion = lib.all (m: m.refreshRate > 0) config.monitors;
        message = "Monitor refresh rate must be greater than 0.";
      }
      {
        assertion = lib.all (
          m:
          # Scale is a string that should be a positive number
          # We'll just check it's not empty and doesn't start with 0 or negative
          m.scale != "" && m.scale != "0" && !(lib.hasPrefix "-" m.scale)
        ) config.monitors;
        message = "Monitor scale must be a positive number (e.g., '1', '1.25', '1.5').";
      }
    ];
  };
}
