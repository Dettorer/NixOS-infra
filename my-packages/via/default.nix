{
  lib, stdenv, runCommand, makeDesktopItem,
  libatomic_ops, glib,
  steam-run, bash
}:

let
  drvName = "via";
  via = stdenv.mkDerivation rec {
    pname = "via";
    version = "20210911";

    src = builtins.fetchurl {
      url = "https://sfc-unistra.classilio.com/Application/Via/Via.tar.gz";
      sha256 = "sha256:d3b8793636129ba69a9108fcee8b5122756b82569bc93f117ab7ad0cb93948aa";
    };
    sourceRoot = ".";

    patches = [
      ./paths.patch
    ];

    nativeBuildInputs = [
      # autoPatchelfHook
    ];

    buildInputs = [
      glib
      libatomic_ops
      stdenv.cc.cc.lib
    ];

    postPatch = ''
      patchShebangs .
    '';

    installPhase = ''
      # Patch pepperflash plugin path
      sed -i "s#/opt/sviesolutions#$out/opt/sviesolutions#g" via/package.nw/package.json

      mkdir -p "$out/bin" "$out/lib"

      mkdir -p "$out/opt/sviesolutions/via"
      cp -r -f via/* "$out/opt/sviesolutions/via"
      ln -s "$out/opt/sviesolutions/via/via" "$out/bin/via"
      ln -s "$out"/opt/sviesolutions/via/lib/* "$out/lib"

      mkdir -p "$out/opt/sviesolutions/viascreensharing"
      cp -r -f viascreensharing/* "$out/opt/sviesolutions/viascreensharing"
      ln -s "$out/opt/sviesolutions/viascreensharing/viascreensharing" "$out/bin/viascreensharing"
      ln -s "$out/opt/sviesolutions/viascreensharing/lib/*" "$out/lib"

      install -D "via/viaIcone.svg" "$out/share/icons/viaIcone.svg"
      install -D "viascreensharing/viascreensharing.svg" "$out/share/icons/viascreensharing.svg"

      chmod 777 -R "$out/opt/sviesolutions/via"
      chmod 777 -R "$out/opt/sviesolutions/viascreensharing"
    '';
  };

  viaDesktopItem = makeDesktopItem {
    name = "via";
    desktopName = "Via Launcher";
    comment = "Via Launcher";
    exec = "via %u";
    icon = "viaIcone.svg";
    categories = "Application;Network;";
    mimeType = "x-scheme-handler/viaapp";
    terminal = false;
    type = "Application";
  };

  viascreensharingDesktopItem = makeDesktopItem {
    name = "viascreensharing";
    desktopName = "ViaScreenSharing Launcher";
    exec = "viascreensharing %u";
    icon = "viascreensharing.svg";
    categories = "Application;Network;";
    mimeType = "x-scheme-handler/viascreensharing";
    terminal = false;
    type = "Application";
  };

  wrapperExtraLibPath = "${via}/opt/sviesolutions/via/lib";
in
  runCommand drvName {
    startScript = ''
      ${steam-run}/bin/steam-run ${bash}/bin/bash -c "LD_LIBRARY_PATH=${wrapperExtraLibPath}:\$LD_LIBRARY_PATH ${via}/opt/sviesolutions/via/via $1"
    '';

    passthru.unwrapped = via;

    meta = with lib; {
      homepage = "https://campus.sfc.unistra.fr";
      description = "Digitaluni backend for videoconferences";
      platforms = platforms.unix;
    };
  }
  ''
    mkdir -p $out/bin
    echo -n "$startScript" > $out/bin/${drvName}
    chmod +x $out/bin/${drvName}

    mkdir -p "$out/share/applications"
    ln -s "${viaDesktopItem}/share/applications/via.desktop" "$out/share/applications"
    ln -s "${viascreensharingDesktopItem}/share/applications/viascreensharing.desktop" "$out/share/applications"
  ''
