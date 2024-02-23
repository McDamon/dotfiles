{ lib, inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./fwupd.nix
    ./locale.nix
    ./nix.nix
    ./nix-ld.nix
    ./openssh.nix
    ./zsh.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  environment = {
    enableAllTerminfo = true;
  };

  networking.domain = "lab.apm-games.com";
}
