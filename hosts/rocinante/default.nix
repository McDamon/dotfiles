{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix
    ../common/global
    ../common/optional/fwupd.nix
    ../common/optional/gnome.nix
    ../common/optional/libvirtd.nix
    ../common/optional/pipewire.nix
    ../common/users/amcmahon
  ];

  networking.hostName = "rocinante";

  networking.networkmanager.enable = true;

  environment = {
    systemPackages = with pkgs; [
      git
      wget
      vim
      docker-compose
      podman-compose
    ];
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
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

  services.asusd = {
    enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}