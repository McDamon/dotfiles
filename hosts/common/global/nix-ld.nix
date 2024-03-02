{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-ld = {
    enable = true;
    package = inputs.nix-ld-rs.packages.${pkgs.hostPlatform.system}.nix-ld-rs;
  };
}
