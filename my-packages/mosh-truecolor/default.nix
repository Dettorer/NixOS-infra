# Derivation copied from nixpkgs (e03c068) with the following modifications:
# - Use fetchGit to pull a more recent commit that has truecolor support
# - Remove the patch that fixes a c++17 ::bind vs std::bind compilation error (fixed upstream on the chosen commit)

{ lib, stdenv, fetchurl, fetchpatch, zlib, protobuf, ncurses, pkg-config
, makeWrapper, perlPackages, openssl, autoreconfHook, openssh, bash-completion
, withUtempter ? stdenv.isLinux, libutempter }:

stdenv.mkDerivation rec {
  pname = "mosh";
  version = "1.3.2";

  src = builtins.fetchGit {
    url = "https://github.com/mobile-shell/mosh.git";
    rev = "68035c18d4d3a7d14855f1f33359afe170b25322"; # arbitrary commit that has truecolor support
  };

  nativeBuildInputs = [ autoreconfHook pkg-config makeWrapper ];
  buildInputs = [ protobuf ncurses zlib openssl bash-completion ]
    ++ (with perlPackages; [ perl IOTty ])
    ++ lib.optional withUtempter libutempter;

  enableParallelBuilding = true;

  patches = [
    ./ssh_path.patch
    ./mosh-client_path.patch
    ./utempter_path.patch
    # Fix build with bash-completion 2.10
    ./bash_completion_datadir.patch
  ];
  postPatch = ''
    substituteInPlace scripts/mosh.pl \
        --subst-var-by ssh "${openssh}/bin/ssh"
    substituteInPlace scripts/mosh.pl \
        --subst-var-by mosh-client "$out/bin/mosh-client"
  '';

  configureFlags = [ "--enable-completion" ] ++ lib.optional withUtempter "--with-utempter";

  postInstall = ''
      wrapProgram $out/bin/mosh --prefix PERL5LIB : $PERL5LIB
  '';

  CXXFLAGS = lib.optionalString stdenv.cc.isClang "-std=c++11";

  meta = with lib; {
    homepage = "https://mosh.org/";
    description = "Mobile shell (ssh replacement)";
    longDescription = ''
      Remote terminal application that allows roaming, supports intermittent
      connectivity, and provides intelligent local echo and line editing of
      user keystrokes.

      Mosh is a replacement for SSH. It's more robust and responsive,
      especially over Wi-Fi, cellular, and long-distance links.
    '';
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ viric ];
    platforms = platforms.unix;
  };
}
