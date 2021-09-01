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

  # TODO: maybe only use an overlay for packages that I override (like mosh) and
  # not for new packages like those after this comment, it may be cleaner to
  # expose those through a my.pkgs module instead.

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

  # A script to cycle between bépo -> azerty -> qwerty -> dvorak keymaps
  keymap-switch = super.writeShellScriptBin "keymap-switch" ''
    alias grep=${self.gnugrep}/bin/grep
    alias sed=${self.gnused}/bin/sed
    alias setxkbmap=${self.xorg.setxkbmap}/bin/setxkbmap

    # Get current keymap
    get_keymap() {
        QUERY="setxkbmap -query"
        KEYMAP=`eval $QUERY | grep 'layout' | sed 's/^layout:     //'`
        VARIANT=`eval $QUERY | grep 'variant' | sed 's/^variant:    //'`
    }

    # Switch between keymaps in this order :
    # bépo
    #   ↓
    # qwerty
    #   ↓
    # azerty
    #   ↓
    # dvorak
    cycle_switch() {
        case $KEYMAP in
        "us") NEWMAP="fr oss" ;;
        "fr")
            case $VARIANT in
                "oss") NEWMAP="dvorak" ;;
                "bepo") NEWMAP="us intl" ;;
                *) NEWMAP="fr bepo" ;; # No idea what is going on, fallback on bepo
            esac ;;
        "dvorak") NEWMAP="fr bepo" ;;
        *) NEWMAP="fr bepo" ;; # No idea what is going on, fallback on bepo
        esac
    }

    if [[ $# -gt 0 ]]
    then
        NEWMAP=$*
    else
        get_keymap
        cycle_switch
    fi

    # Change keymap
    eval "setxkbmap $NEWMAP"

    # setxkbmap broke the caps lock / escape swap
    setxkbmap -option caps:swapescape
  '';
}
