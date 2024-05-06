{
  description = "amcmahon nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-contrib.url = "github:hyprwm/contrib";
  };

  outputs =
    inputs @ { self
    , home-manager
    , nixpkgs
    , lanzaboote
    , nixos-wsl
    , hyprland
    , ...
    }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      overlays = import ./overlays { inherit inputs outputs; };

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./devshell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        nixos-wsl = lib.nixosSystem {
          modules = [
            ./hosts/nixos-wsl
          ];
          specialArgs = { inherit inputs outputs; };
        };
        razorback = lib.nixosSystem {
          modules = [
            ./hosts/razorback
            hyprland.nixosModules.default
            lanzaboote.nixosModules.lanzaboote
          ];
          specialArgs = { inherit inputs outputs; };
        };
        rocinante = lib.nixosSystem {
          modules = [
            ./hosts/rocinante
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
            hyprland.homeManagerModules.default
            ./home/amcmahon/razorback.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "amcmahon@rocinante" = lib.homeManagerConfiguration {
          modules = [
            hyprland.homeManagerModules.default
            ./home/amcmahon/rocinante.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
