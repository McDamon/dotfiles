{
  description = "amcmahon nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    inputs@{ self
    , hardware
    , home-manager
    , nix-colors
    , nixpkgs
    , ...
    }:
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
      devShells = forEachSystem (pkgs: import ./devshell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      wallpapers = import ./home/amcmahon/wallpapers;

      nixosConfigurations = {
        razorback = lib.nixosSystem {
          modules = [
            ./hosts/razorback
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
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
