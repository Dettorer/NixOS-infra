# This is a nixpkgs overlay adds my own custom packages to pkgs (possibly
# overriding some of them)
self: super: {
  # Until upstream mosh decides to release a new version, use a more recent
  # commit that has truecolor support (pkgs.mosh-truecolor is a custom package
  # added via an overlay)
  mosh = (
    if super.mosh.version <= "1.3.2" then
      super.callPackage ./mosh-truecolor {}
    else
      super.mosh
  );
  geany-plugin-m68k = super.qt5.callPackage ./geany-plugin-m68k {};
}
