{ config, lib, pkgs, ... }:

let
  cfg = config.programs.faf-client;
  package = pkgs.faf-client;
in
{
  options.programs.faf-client = {
    enable = lib.mkEnableOption "faf-client";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ package ];
  };
}
