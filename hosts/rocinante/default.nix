{ lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../optional/hyprland.nix
    ../optional/1password.nix
    ../optional/firewall.nix
    ../optional/fwupd.nix
    ../optional/libvirtd.nix
    ../optional/pipewire.nix
    ../optional/steam.nix
    ../users/amcmahon
  ];

  networking.hostName = "rocinante";

  networking.networkmanager.enable = true;

  environment = {
    systemPackages = with pkgs; [
      git
      wget
      vim
      podman-compose # Use podman-compose instead of docker-compose
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  services.fprintd = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

  # Hyprland uses Wayland and does not need an X11 session
  services.xserver.enable = false;

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
      dockerCompat = true; # Provides 'docker' command via podman
      defaultNetwork.settings.dns_enabled = true;
      autoPrune = {
        enable = true;
        dates = "daily";
      };
    };
    # Docker disabled in favor of Podman with Docker compatibility
    docker.enable = false;
  };

  programs = {
    light.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
