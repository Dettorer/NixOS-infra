# This is a nixpkgs overlay adds my own custom packages to pkgs (possibly
# overriding some of them)
final: prev: {
  _my = {
    # Geany with an m68k compiler/emulator/debugger plugin
    geany-plugin-m68k = prev.qt5.callPackage ./geany-plugin-m68k {};
    geany-epita = prev.geany.overrideAttrs (old: rec {
      postInstall = ''
        cp ${final._my.geany-plugin-m68k}/editor/filetypes.asm $out/share/geany/filedefs/filetypes.asm
      '';

      meta = old.meta // {
        # geany-plugin-m68k is only supported on Linux
        platforms = final.lib.platforms.linux;
      };
    });

    # A script to cycle between bépo -> azerty -> qwerty -> dvorak keymaps
    keymap-switch = prev.writeShellScriptBin "keymap-switch" ''
      alias grep=${final.gnugrep}/bin/grep
      alias sed=${final.gnused}/bin/sed
      alias setxkbmap=${final.xorg.setxkbmap}/bin/setxkbmap

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

    # ibus with mozc-ut (to make it easier to install on non-nixos with nix
    # profile install)
    ibus-mozc-ut = prev.ibus-with-plugins.override {
      plugins = [ prev.ibus-engines.mozc-ut ];
    };
  };
}
