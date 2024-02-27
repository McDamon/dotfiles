# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../common/global
    ../common/users/amcmahon
  ];

  networking.hostName = "nixos-wsl";

  environment = {
    systemPackages = with pkgs; [
      git
      wget
      vim
      docker-compose  
      podman-compose
    ];
  };

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.network.generateResolvConf = false;
    defaultUser = "amcmahon";
    startMenuLaunchers = true;
    nativeSystemd = true;
    usbip.enable = true;
  };

  # usbipd-win
  #fileSystems."/var/run/usbipd-win" = {
  #  device = "C:\\Program Files\\usbipd-win\\WSL";
  #  fsType = "drvfs";
  #  options = [
  #    "ro"
  #    "umask=222"
  #  ];
  #};

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
    ];
  };
  
  virtualisation = {
    containers.cdi.dynamic.nvidia.enable = true;
    podman = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "daily";
      };
    };
    docker = {
      enable = true;
      package = pkgs.docker_25;
      autoPrune = {
        enable = true;
        dates = "daily";
      };
      daemon.settings = {
        features = {
          cdi = true;
        };
      };
    };
  };

  # Needs to be set explicitly because nixos-wsl disables this for ease of installation
  security.sudo.wheelNeedsPassword = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
