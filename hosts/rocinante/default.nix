{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../optional/1password.nix
    ../optional/gnome.nix
    ../optional/firewall.nix
    ../optional/fwupd.nix
    ../optional/libvirtd.nix
    ../optional/pipewire.nix
    ../optional/steam.nix
    ../users/amcmahon
  ];

  networking.hostName = "rocinante";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

  environment = {
    systemPackages =
      (with pkgs; [
        git
        wget
        vim
        docker-compose
        podman-compose
      ])
      ++ [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
      ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;

    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  hardware.enableAllFirmware = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  services.fwupd.enable = true;

  services.fprintd = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    nvidiaPersistenced = true;
  };

  hardware.nvidia-container-toolkit.enable = true;

  virtualisation = {
    podman = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "daily";
      };
    };
    docker = {
      enable = true;
      package = pkgs.docker;
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.05";
}
