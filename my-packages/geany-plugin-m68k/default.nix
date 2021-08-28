{ lib, stdenv, autoPatchelfHook, qtbase, wrapQtAppsHook, libdrm, mesa }:

stdenv.mkDerivation rec {
  pname = "geany-plugin-m68k";
  version = "1.0";

  src = builtins.fetchTarball {
    url = "https://dettorer.net/epita/TP_68000_Ubuntu64.tar.gz";
    sha256 = "1jnqw0cb3pwdic18py8gqpm3vwm5q8c37h5jcxv2rv1zm0m7kzkp";
  };

  nativeBuildInputs = [ autoPatchelfHook wrapQtAppsHook ];
  buildInputs = [ qtbase libdrm mesa ];

  preFixup = ''
    sed -i 's/appname=.*/appname=d68k/' "$out/68000/d68k.sh"
    wrapQtApp "$out/68000/d68k.sh"
  '';

  installPhase = ''
    find 68000 -type f -exec install -Dm 755 "{}" "$out/{}" \;
    find editor -type f -exec install -Dm 755 "{}" "$out/{}" \;
  '';

  meta = with lib; {
    homepage = "http://www.debug-pro.com/epita/archi/s3/fr/";
    description = "Geany plugin to program and emulate execution of Motorola 68000 applications";
    platforms = platforms.unix;
  };
}
