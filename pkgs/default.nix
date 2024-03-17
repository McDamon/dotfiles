{ pkgs }: {
  faf-client = pkgs.callPackage ./faf-client {
    jdk = pkgs.temurin-bin-21;
  };
  wallpapers = pkgs.callPackage ./wallpapers { };
}
