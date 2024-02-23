{ pkgs }:
{
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
    qemu.ovmf.package = [ pkgs.OVMFFull ];
    qemu.swtpm.enable = true;
  };

  environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
}