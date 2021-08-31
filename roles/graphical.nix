{ config, lib, pkgs, ... }:

let
  cfg = config.my.roles.graphical;
in {
  options.my.roles.graphical = {
    enable = lib.mkEnableOption "Graphical behavior and tools";
  };

  config = lib.mkIf cfg.enable {
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
      unifont_upper
    ];

    services.picom = {
      enable = true;
      backend = "glx";
      shadow = true;

      shadowOpacity = 0.75;
      shadowOffsets = [ (-5) (-5) ];
      shadowExclude = [
        "! name~=''"
        "name = 'Notification'"
        "name = 'Plank'"
        "name = 'Docky'"
        "name = 'Kupfer'"
        "name = 'xfce4-notifyd'"
        "name = 'cpt_frame_window'"
        "name *= 'VLC'"
        "name *= 'compton'"
        "name *= 'picom'"
        "name *= 'Chromium'"
        "name *= 'Chrome'"
        "class_g = 'Firefox' && argb"
        "class_g = 'Conky'"
        "class_g = 'Kupfer'"
        "class_g = 'Synapse'"
        "class_g ?= 'Notify-osd'"
        "class_g ?= 'Cairo-dock'"
        "class_g ?= 'Xfce4-notifyd'"
        "class_g ?= 'Xfce4-power-manager'"
        "_GTK_FRAME_EXTENTS@:c"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      ];

      inactiveOpacity = 1.0;
      activeOpacity = 1.0;

      fade = true;
      fadeDelta = 4;
      fadeSteps = [ 0.33 0.03 ];

      refreshRate = 0;
      vSync = true;

      wintypes = {
        "tooltip" = {
          fade = true;
          shadow = false;
          opacity = 0.85;
          focus = true;
        };
      };

      settings = {
        shadow-radius = 12;
        xinerama-shadow-crop = true;

        frame-opacity = 1;
        inactive-opacity-override = false;
        detect-client-opacity = true;

        blur-backgroupnd = true;
        blur-background-frame = true;
        blur-background-fixed = false;
        blur-background-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
        ];

        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        use-ewmh-active-win = true;
        detect-rounded-corners = true;

        dbe = false;
        unredir-if-possible = false;
        detect-transient = true;
        detect-client-leader = true;

        xrender-sync-fence = true;
      };
    };

    programs.nm-applet.enable = true;

    programs.dconf.enable = true;

    boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
    boot.kernelModules = [ "v4l2loopback" ];

    environment.systemPackages = with pkgs; [
      thunderbird
      firefox
      chromium
      teams
      discord
      libreoffice
      hunspellDicts.fr-moderne
      xournalpp
      pentablet-driver
      evince
      obs-studio
      mpv
      vlc
      nitrogen
      arandr
      gnome.eog

      gnome.adwaita-icon-theme
    ];
  };
}
