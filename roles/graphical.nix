{ config, lib, pkgs, ... }:

let
  cfg = config.my.roles.graphical;
in {
  options.my.roles.graphical = {
    enable = lib.mkEnableOption "Graphical behavior and tools";
  };

  config = lib.mkIf cfg.enable {
    services.picom.enable = true;
    services.xserver = {
      enable = true;

      libinput.enable = true;

      layout = "fr";
      xkbVariant = "bepo";
      xkbOptions = "caps:swapescape";

      windowManager.i3.enable = true;

      displayManager = {
        sddm.enable = true;
        sddm.autoNumlock = true;

        # By default, use an xsession script generated by home-manager
        # TODO: factorize the scripts' path with home-manager
        defaultSession = "none+xsession";
        session = [{
          manage = "window";
          name = "xsession";
          start = ''
            ${pkgs.runtimeShell} $HOME/.xsession &
            waitPID=$!
          '';
        }];

        autoLogin.enable = true;
        autoLogin.user = "dettorer";

        setupCommands = ''${pkgs.xorg.xset}/bin/xset s off -dpms'';
      };
    };

    fonts.fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "DejaVuSansMono" "Iosevka" "Meslo" ]; })
    ];

    programs.nm-applet.enable = true;

    environment.systemPackages = with pkgs; [
      thunderbird
      firefox
      teams
      discord
      libreoffice
      hunspellDicts.fr-moderne
      xournalpp
      pentablet-driver
      evince
      obs-studio
    ];
  };
}
