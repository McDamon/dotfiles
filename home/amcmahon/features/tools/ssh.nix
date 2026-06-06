{ config, ... }:
let
  onePassPath = "${config.home.homeDirectory}/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        identityAgent = onePassPath;
      };
    };
  };
}
