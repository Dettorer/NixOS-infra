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

  # Geany with an m68k compiler/emulator/debugger plugin
  geany-plugin-m68k = super.qt5.callPackage ./geany-plugin-m68k {};
  geany-epita = super.geany.overrideAttrs (old: rec {
    postInstall = ''
      cp ${self.geany-plugin-m68k}/editor/filetypes.asm $out/share/geany/filedefs/filetypes.asm
    '';

    meta = old.meta // {
      # geany-plugin-m68k is only supported on Linux
      platforms = self.lib.platforms.linux;
    };
  });
}
