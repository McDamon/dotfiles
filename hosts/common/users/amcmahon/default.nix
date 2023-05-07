{ pkgs, config, lib, outputs, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.amcmahon = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Andrew McMahon";
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "networkmanager"
      "wireshark"
      "docker"
      "podman"
      "git"
      "libvirtd"
    ];
    openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/amcmahon/ssh.pub) ];
    passwordFile = config.sops.secrets.amcmahon-password.path;
  };

  sops.secrets.amcmahon-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  services.geoclue2.enable = true;

  security.pam.services = { swaylock = { }; };
}
