{
  description = "amcmahon nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    lanzaboote.url = "github:nix-community/lanzaboote";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nix-ld-rs.url = "github:nix-community/nix-ld-rs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    inputs @ { self
    , hardware
    , home-manager
    , nixpkgs
    , lanzaboote
    , nixos-wsl
    , nix-ld-rs
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
            ./home/amcmahon/rocinante.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
