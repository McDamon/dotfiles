{ pkgs
, config
, ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.amcmahon = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Andrew McMahon";
    extraGroups =
      [
        "wheel"
      ]
      ++ ifTheyExist [
        "audio"
        "networkmanager"
        "docker"
        "podman"
        "git"
        "i2c"
        "libvirtd"
      ];
  };

  security.pam.services = { swaylock = { }; };
}
