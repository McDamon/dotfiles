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
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
      luks.devices = {
        "luks-cfd76105-8f1f-4cbe-b241-6ad488a0b895".device = "/dev/disk/by-uuid/cfd76105-8f1f-4cbe-b241-6ad488a0b895";
        "luks-719bf5fd-c2bc-4ab9-af18-04a2cae4bb1f".device = "/dev/disk/by-uuid/719bf5fd-c2bc-4ab9-af18-04a2cae4bb1f";
      };
    };
    kernelModules = [ "kvm-amd" ];
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
    device = "/dev/disk/by-uuid/b022f52b-ceb1-4e40-8b45-44cfdf596913";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/58C3-1DBE";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/storage" = {
    device = "/dev/disk/by-uuid/da57b05a-b1f8-4d71-b9fb-80843415bb24";
    fsType = "ext4";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  services.fstrim.enable = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
