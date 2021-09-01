{ pkgs, ... }:

let
  xkeyboard = pkgs.writeShellScriptBin "xkeyboard" ''
    ${pkgs.xorg.setxkbmap}/bin/setxkbmap -print | ${pkgs.gnugrep}/bin/grep xkb_symbols | ${pkgs.gawk}/bin/awk -F"+" '{print $2}'
  '';
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    MENU="$(${pkgs.rofi}/bin/rofi -sep "|" -dmenu -i -p 'System' -location 3 -xoffset -10 -yoffset 32 -width 10 -hide-scrollbar -line-padding 4 -padding 20 -lines 4 <<< " Lock| Logout| Reboot| Shutdown")"
    case "$MENU" in
        *Lock) ${pkgs.i3lock}/bin/i3lock ;;
        *Logout) ${pkgs.i3}/bin/i3-msg exit ;;
        *Reboot) ${pkgs.systemd}/bin/systemctl reboot ;;
        *Shutdown) ${pkgs.systemd}/bin/systemctl -i poweroff
    esac
  '';
in
{
  # TODO: find something useful for when I click on the top-left feather
  # ("colors-switch" module, to be renamed)

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
    };

    script = ''
      polybar rivamar-top &
      polybar rivamar-bottom &
      polybar rivamar-top-alt &
      polybar rivamar-bottom-alt &
    '';

    # TODO: translate to a nix set and use "settings" instead of "extraConfig"
    extraConfig = with builtins;
      ( readFile ./polybar/colors.ini
      + readFile ./polybar/modules.ini
      + replaceStrings # TODO: path seems ok for keymap-switch but clicking the module doesn't do anything
      [
        "%%keymap_switch%%"
        "%%xkeyboard%%"
        "%%powermenu%%"
      ]
      [
        "${pkgs.keymap-switch}/bin/keymap-switch"
        "${xkeyboard}/bin/xkeyboard"
        "${powermenu}/bin/powermenu"
      ]
      (readFile ./polybar/user_modules.ini)
      + readFile ./polybar/bars.ini
      + readFile ./polybar/config.ini
      );
  };
}
