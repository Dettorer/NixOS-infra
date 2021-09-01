{
  lib, stdenv, mkDerivation, autoPatchelfHook, ps,
  libusb1, libX11, libXtst, qtbase, qtx11extras, libglvnd,
  buildFHSUserEnv, runCommand
}:

let
  drvName = "pentablet-driver";

  pentablet-driver = mkDerivation rec {
    pname = drvName;
    version = "3.2.0.210824";

    src = builtins.fetchTarball {
      url = "https://download01.xp-pen.com/file/2021/08/XP-PEN-pentablet-${version}-1.x86_64.tar.gz";
      sha256 = "sha256:1kg3j1j3fakrq25fdw9fhcmb51gm541r43j682acfw8l3s4xm0q7";
    };# + /Linux_Pentablet_V1.2.13.1.tar.gz;

    patches = [
      ./install-destination-path.patch
    ];

    nativeBuildInputs = [
      autoPatchelfHook
      ps
    ];

    buildInputs = [
      libusb1
      libX11
      libXtst
      qtbase
      qtx11extras
      libglvnd
      stdenv.cc.cc.lib
    ];

    postPatch = ''
      patchShebangs .
    '';

    installPhase = ''
      mkdir -p "fake-root/usr/lib/pentablet"
      mkdir -p "fake-root/usr/share/applications"
      mkdir -p "fake-root/usr/share/icons/"
      mkdir -p "fake-root/etc/xdg/autostart"
      mkdir -p "fake-root/usr/lib/udev/rules.d/"

      ./install.sh "fake-root"

      install -D fake-root/usr/lib/pentablet/pentablet $out/bin/pentablet
      install -D fake-root/usr/lib/udev/rules.d/10-xp-pen.rules $out/lib/udev/rules.d/10-xp-pen.rules
    '';

    # TODO: desktopItem
  };

  fhsEnv = buildFHSUserEnv {
    name = "${drvName}-fhs-env";
  };
in
  runCommand drvName {
    startScript = ''
      ${fhsEnv}/bin/${drvName}-fhs-env ${pentablet-driver}/bin/pentablet
    '';
    passthru.unwrapped = pentablet-driver;

    meta = with lib; {
      homepage = "https://www.xp-pen.com/download/index.html";
      description = "Driver for XP-PEN Pentablet drawing tablets";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
    };
  }
  ''
    mkdir -p $out/bin
    echo -n "$startScript" > $out/bin/${drvName}
    chmod +x $out/bin/${drvName}

    mkdir -p $out/usr/lib/pentablet/conf/xppen
  ''
