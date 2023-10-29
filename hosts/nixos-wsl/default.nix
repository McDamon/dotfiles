# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../common/global
    ../common/users/amcmahon
  ];

  networking.hostName = "nixos-wsl";

  environment = {
    systemPackages = with pkgs; [
      git
      wget
      vim
    ];
  };

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "amcmahon";
    startMenuLaunchers = true;
    nativeSystemd = true;
  };

  # Needs to be set explicitly because nixos-wsl disables this for ease of installation
  security.sudo.wheelNeedsPassword = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
