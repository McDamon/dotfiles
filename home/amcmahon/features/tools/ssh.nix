{ ... }:
let
  onePassPath = "/home/amcmahon/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityAgent = onePassPath;
      };

      "alnilam" = {
        hostname = "alnilam.lab.apm-games.com";
        user = "amcmahon";
      };

      "antares" = {
        hostname = "antares.lab.apm-games.com";
        user = "root";
      };

      "arcturus" = {
        hostname = "arcturus.lab.apm-games.com";
        user = "amcmahon";
      };

      "donnager" = {
        hostname = "donnager.lab.apm-games.com";
        user = "root";
      };

      "nauvoo" = {
        hostname = "nauvoo.lab.apm-games.com";
        user = "root";
      };
    };
  };

  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat .ssh/config_source > .ssh/config'';
  };
}
