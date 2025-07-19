{ ... }:
let
  onePassPath = "/home/amcmahon/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
    Host *
      IdentityAgent ${onePassPath}

    Host alnilam
      Hostname alnilam.lab.apm-games.com
      User amcmahon

    Host antares
      Hostname antares.lab.apm-games.com
      User root

    Host arcturus
      Hostname arcturus.lab.apm-games.com
      User amcmahon
    
    Host donnager
      Hostname donnager.lab.apm-games.com
      User root

    Host nauvoo
      Hostname nauvoo.lab.apm-games.com
      User root
    '';
  };

  home.file.".ssh/config" = {
    target = ".ssh/config_source";
    onChange = ''cat .ssh/config_source > .ssh/config'';
  };
}
