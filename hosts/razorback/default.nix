{ inputs, lib, pkgs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix
    ../common/global
    ../common/optional/gnome.nix
    ../common/optional/pipewire.nix
    ../common/users/amcmahon
  ];

  networking.hostName = "razorback";

  networking.networkmanager.enable = true;

  environment = {
    systemPackages = with pkgs; [
      git
      wget
      vim
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
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
    nvidiaPersistenced = true;
    powerManagement.enable = true;
    prime = {
      reverseSync.enable = true;

      # Make sure to use the correct Bus ID values for your system!
      amdgpuBusId = "PCI:66:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };

  boot.bootspec.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
