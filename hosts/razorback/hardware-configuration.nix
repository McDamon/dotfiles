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
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
      luks.devices = {
        "luks-a927055e-2653-43cc-8010-ccf74a9d7577".device =
          "/dev/disk/by-uuid/a927055e-2653-43cc-8010-ccf74a9d7577";
        "luks-e7be9226-e962-45c1-93ef-7af8caabf4f3".device =
          "/dev/disk/by-uuid/e7be9226-e962-45c1-93ef-7af8caabf4f3";
      };
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    loader.systemd-boot.enable = lib.mkForce false;
    loader.efi.canTouchEfiVariables = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    plymouth.enable = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d5ad651b-bf8b-46b5-87ba-8d8356a83a6a";
    fsType = "ext4";
  };

  fileSystems."/storage" = {
    device = "/dev/disk/by-uuid/15a9f837-a603-47c9-9b39-c0a2c3b36baa";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/61AB-CA7C";
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
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
