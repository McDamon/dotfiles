{ lib, stdenv, fetchzip, makeWrapper, jdk, pkgs, ... }:
stdenv.mkDerivation rec {
  pname = "downlords-faf-client";
  version = "v2024.1.2";

  src = fetchzip {
    url = "https://github.com/FAForever/downlords-faf-client/releases/download/${version}/faf_unix_${lib.stringAsChars (x: if x == "." then "_" else if x == "v" then "" else x) version}.tar.gz";
    sha256 = "sha256-etClhC/bulDsc5naiXeGnSPyl5jytoqzqApWY3pJ9Fs=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    jdk
  ];

  systemLibs = with pkgs; [
    alsa-lib
    fontconfig
    freetype
    glib
    gtk3
    libGL
    pango
    xorg.libX11
    xorg.libXtst
    xorg.libXxf86vm
    stdenv.cc.cc.lib
  ];
  systemLibPaths = lib.makeLibraryPath systemLibs;

  installPhase = ''
    mkdir -p $out/lib/ $out/bin
    cp -r ${src} $out/lib/downlords

    makeWrapper $out/lib/downlords/faf-client $out/bin/faf-client \
      --set INSTALL4J_JAVA_HOME_OVERRIDE ${jdk.home} \
      --add-flags '-Djava.library.path=${systemLibPaths}' \
      --prefix LD_LIBRARY_PATH : '${systemLibPaths}' \
      --set PWD $out/lib/downlords \
      --run "cd $out/lib/downlords"
  '';

}
