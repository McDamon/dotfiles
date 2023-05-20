{ pkgs ? (import ../nixpkgs.nix) { } }: {
  faf-client = pkgs.callPackage ./faf-client { };
  shellcolord = pkgs.callPackage ./shellcolord { };
  primary-xwayland = pkgs.callPackage ./primary-xwayland { };
}
