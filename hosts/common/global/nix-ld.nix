{ pkgs, self, ... }:
{
  programs.nix-ld = {
    enable = true;
    package = self.inputs.nix-ld-rs.packages.${pkgs.hostPlatform.system}.nix-ld-rs;
  };
}
