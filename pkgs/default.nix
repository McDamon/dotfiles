{ pkgs ? (import ../nixpkgs.nix) { } }: {
  shellcolord = pkgs.callPackage ./shellcolord { };
  primary-xwayland = pkgs.callPackage ./primary-xwayland { };
}
