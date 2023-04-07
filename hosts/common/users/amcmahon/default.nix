{ pkgs, config, lib, outputs, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.amcmahon = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Andrew McMahon";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  services.geoclue2.enable = true;

  security.pam.services = { swaylock = { }; };
}
