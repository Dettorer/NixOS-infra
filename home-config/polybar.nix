{ pkgs, ... }:

{
  xdg.dataFile."fonts/icomoon-feather.ttf".source = ./custom-fonts/icomoon-feather.ttf;

  # TODO: properly package these scripts
  xdg.configFile."polybar/scripts/xkeyboard-short.sh" = {
    text = ''${pkgs.xorg.setxkbmap}/bin/setxkbmap -print | ${pkgs.gnugrep}/bin/grep xkb_symbols | ${pkgs.gawk}/bin/awk -F"+" '{print $2}' '';
    executable = true;
  };

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
    extraConfig = with builtins; (
      readFile ./polybar/colors.ini
      + readFile ./polybar/modules.ini
      + readFile ./polybar/user_modules.ini
      + readFile ./polybar/bars.ini
      + readFile ./polybar/config.ini
    );
  };
}
