{ config
, inputs
, lib
, pkgs
, ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix
    ../common/global
    #../common/optional/gnome.nix
    ../common/optional/hyprland.nix
    ../common/optional/themed-sddm.nix
    ../common/optional/fwupd.nix
    ../common/optional/firewall.nix
    ../common/optional/pipewire.nix
    ../common/optional/1password.nix
    ../common/optional/steam.nix
    ../common/users/amcmahon
  ];

  networking.hostName = "rocinante";

  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      git
      wget
      vim
      docker-compose
      podman-compose
    ];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
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

  services.hardware.openrgb.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
