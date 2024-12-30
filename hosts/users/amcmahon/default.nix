{
  pkgs,
  config,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.amcmahon = {
    isNormalUser = true;
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJiE8XwKjtHZ7qaus5y4CbQn7+lsi3F5bI0wrCgWl/14 andrew.p.mcmahon@gmail.com"
    ];
  };
}
