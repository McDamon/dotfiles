{
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
        "luks-43fd632b-4061-4a76-9d25-f932696bb07b".device = "/dev/disk/by-uuid/43fd632b-4061-4a76-9d25-f932696bb07b";
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

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bda6e41f-806c-4efc-9ce7-6cda87ea54ac";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4008-6B71";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  services.fstrim.enable = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
