{
  description = "amcmahon nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      home-manager,
      nixpkgs,
      lanzaboote,
      ...
    }:
    let
      inherit (self) outputs;
      baseLib = nixpkgs.lib // home-manager.lib;
      homeManagerModules = import ./modules/home-manager;
      lib = baseLib // {
        inherit homeManagerModules;
      };
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;

      overlays = import ./overlays { inherit inputs outputs; };

      packages = forEachSystem (
        pkgs:
        let
          customPkgs = import ./pkgs { inherit pkgs; };
          wallpapers = lib.filterAttrs (_: value: lib.isDerivation value) customPkgs.wallpapers;
        in
        wallpapers
        // {
          default = builtins.head (builtins.attrValues wallpapers);
        }
      );
      devShells = forEachSystem (pkgs: import ./bootstrap-shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixfmt);

      nixosConfigurations = {
        rocinante = lib.nixosSystem {
          modules = [
            ./hosts/rocinante
            lanzaboote.nixosModules.lanzaboote
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };

      homeConfigurations = {
        "amcmahon@rocinante" = lib.homeManagerConfiguration {
          modules = [
            ./home/amcmahon/rocinante.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
}
