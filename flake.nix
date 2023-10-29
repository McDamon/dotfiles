{
  description = "amcmahon nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-wsl, home-manager, ... }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      overlays = import ./overlays { inherit inputs outputs; };

      packages = forEachSystem (pkgs: (import ./pkgs { inherit pkgs; }) // { });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        nixos-wsl = lib.nixosSystem {
          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/nixos-wsl
          ];
          specialArgs = { inherit inputs outputs; };
        };
        razorback = lib.nixosSystem {
          modules = [
            ./hosts/razorback
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "amcmahon@nixos-wsl" = lib.homeManagerConfiguration {
          modules = [
            ./home/amcmahon/nixos-wsl.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "amcmahon@razorback" = lib.homeManagerConfiguration {
          modules = [
            ./home/amcmahon/razorback.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
