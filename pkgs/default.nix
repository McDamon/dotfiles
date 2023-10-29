{ pkgs ? (import ../nixpkgs.nix) { } }: {
  shellcolord = pkgs.callPackage ./shellcolord { };
}
