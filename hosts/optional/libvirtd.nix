{ ... }:
{
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  environment.sessionVariables.LIBVIRT_DEFAULT_URI = "qemu:///system";
}
