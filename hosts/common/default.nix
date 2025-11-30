{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./nix-ld.nix
    ./locale.nix
    ./nix.nix
    ./openssh.nix
  ]
  ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.dconf.enable = true;

  services.flatpak.enable = true;

  networking.domain = "lab.apm-games.com";
}
