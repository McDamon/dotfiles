{ pkgs
, lib
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader
  boot = {
    loader.systemd-boot.enable = lib.mkForce true;
    loader.efi.canTouchEfiVariables = true;
  };
  
  boot.plymouth.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/da78d952-e0e2-498a-93ed-e1cb3562f4aa";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/82E5-8424";
    fsType = "vfat";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  services.fstrim.enable = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
}
