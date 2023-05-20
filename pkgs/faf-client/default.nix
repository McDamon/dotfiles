{
  lib,
  stdenv,
  makeWrapper,
  makeDesktopItem,
  # regular jdk doesnt work due to problems with JavaFX even with .override { enableJavaFX = true; }
  openjdk17-bootstrap,
  xorg,
  libGL,
  gtk3,
  glib,
  alsa-lib
}: let
  pname = "faf-client";

  version = "2023.4.0";
  sha256 = "10mvygz164sih0f046vr5gpg1sb7rffqjrwz6ih1nrypsihz4zkn";
  src = builtins.fetchTarball {
    url = "https://github.com/FAForever/downlords-faf-client/releases/download/v${version}/faf_unix_${builtins.replaceStrings ["."] ["_"] version}.tar.gz";
    sha256 = sha256;
  };

  meta = with lib; {
    description = "Official client for Forged Alliance Forever";
    homepage = "https://github.com/FAForever/downlords-faf-client";
    license = licenses.mit;
  };

  icon = builtins.fetchurl {
    url = "https://github.com/FAForever/downlords-faf-client/raw/11f5d9a7a728883374510cdc0bec51c9aa4126d7/src/media/appicon/256.png";
    name = "faf-client.png";
    sha256 = "0zc2npsiqanw1kwm78n25g26f9f0avr9w05fd8aisk191zi7mj5r";
  };

  desktopItem = makeDesktopItem {
    inherit icon;
    name = "faf-client";
    exec = "faf-client";
    comment = meta.description;
    desktopName = "Forged Alliance Forever";
    categories = ["Game"];
    keywords = ["FAF" "Supreme Commander"];
  };

  libs = [
    alsa-lib
    glib
    gtk3.out
    libGL
    xorg.libXxf86vm
    stdenv.cc.cc.lib 
  ];
in
  stdenv.mkDerivation {
    inherit pname meta desktopItem;
    version = version;
    src = src;

    preferLocalBuild = true;
    nativeBuildInputs = [makeWrapper];

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp -rfv * .install4j $out

      mkdir $out/bin
      makeWrapper $out/faf-client $out/bin/faf-client \
        --chdir $out \
        --set INSTALL4J_JAVA_HOME ${openjdk17-bootstrap} \
        --suffix LD_LIBRARY_PATH : ${lib.strings.makeLibraryPath libs}

      ln -s ../natives/faf-uid $out/lib/faf-uid

      mkdir $out/share
      cp -r ${desktopItem}/share/* $out/share/

      runHook postInstall
    '';

    passthru.updateScript = ./update.sh;
  }