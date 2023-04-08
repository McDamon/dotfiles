{ pkgs, config, inputs, ... }:
{
  home.packages = [ inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.fac-client ];
}
