{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # Bootloader
  boot = {
    loader.systemd-boot.enable = lib.mkForce false;
    loader.efi.canTouchEfiVariables = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  # Use the latest kernel to support Wi-Fi
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/9c72fa2e-b599-4bd2-9220-ca5fb36daa8e";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-8bc80548-87ff-4ecf-ab58-d333306f4336".device = "/dev/disk/by-uuid/8bc80548-87ff-4ecf-ab58-d333306f4336";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/E9DE-A46A";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  services.fstrim.enable = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # Gnome 40 introduced a new way of managing power, without tlp.
  # However, these 2 services clash when enabled simultaneously.
  # https://github.com/NixOS/nixos-hardware/issues/260
  services.tlp.enable = lib.mkDefault ((lib.versionOlder (lib.versions.majorMinor lib.version) "21.05")
                                       || !config.services.power-profiles-daemon.enable);
                                       
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
