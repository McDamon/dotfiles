{
  pkgs,
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [ ];
      luks.devices = {
        "luks-33e2e3db-01a3-439f-bd6a-f09b82e6c6f1".device = "/dev/disk/by-uuid/33e2e3db-01a3-439f-bd6a-f09b82e6c6f1";
      };
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    loader.systemd-boot.enable = lib.mkForce false;
    loader.efi.canTouchEfiVariables = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    plymouth.enable = true;
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/cf8dc668-9262-4950-a5dd-ae06042c4f43";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/748D-2921";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  services.fstrim.enable = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
