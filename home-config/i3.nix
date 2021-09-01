{ pkgs, ... }:

let
  mod = "Mod4";
  defaultTerminal = "${pkgs.alacritty}/bin/alacritty"; # TODO: factorize the prefered terminal accross the whole config
in {
  imports = [ ./polybar.nix ];

  xdg.configFile."rofi/onedark.rasi".source = ./rofi-onedark-theme.rasi;
  programs.rofi = {
    enable = true;
    terminal = defaultTerminal;
    font = "DejaVu Sans Mono Nerd Font 12";
    theme = "onedark";
  };

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      fonts = {
        names = [ "DejaVu Sans Mono" ];
      };
      gaps = {
        inner = 7;
        outer = 0;
        smartBorders = "on";
        smartGaps = true;
      };
      menu = "${pkgs.rofi}/bin/rofi -show drun"; # TODO: not sure if needed
      terminal = defaultTerminal;

      modifier = mod;
      floating.modifier = mod;

      workspaceAutoBackAndForth = true;

      keybindings = {
        # These bindings are for a bépo keymap

        # start a terminal
        "${mod}+Return" = "exec ${defaultTerminal}";
        "${mod}+Shift+Return" = "exec i3-sensible-terminal";

        # kill focused window
        "${mod}+Shift+B" = "kill";

        # rofi app and window launchers
        ## Launch // Application // <Super> Space ##
        "${mod}+i" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        ## Launch // Command // <Super><Shift> i ##
        "${mod}+Ctrl+i" = "exec ${pkgs.rofi}/bin/rofi -show run";
        ## Navigate // Window by Name // <Super><Ctrl> i ##
        "${mod}+Shift+i" = "exec ${pkgs.rofi}/bin/rofi -show window";

        # change focus, vim like
        "${mod}+c" = "focus left";
        "${mod}+t" = "focus down";
        "${mod}+s" = "focus up";
        "${mod}+r" = "focus right";

        # move focused window, vim like
        "${mod}+Shift+C" = "move left";
        "${mod}+Shift+T" = "move down";
        "${mod}+Shift+S" = "move up";
        "${mod}+Shift+R" = "move right";

        # alternatively, you can use the cursor keys:
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # split in horizontal orientation
        "${mod}+h" = "split h";

        # split in vertical orientation
        "${mod}+period" = "split v";

        # enter fullscreen mode for the focused container
        "${mod}+e" = "fullscreen";

        # change container layout (stacked, tabbed, default)
        "${mod}+u" = "layout stacking";
        "${mod}+eacute" = "layout tabbed";
        "${mod}+p" = "layout default";

        # toggle tiling / floating
        "${mod}+Shift+nobreakspace" = "floating toggle";

        # change focus between tiling / floating windows
        "${mod}+space" = "focus mode_toggle";

        # focus the parent container
        "${mod}+a" = "focus parent";

        # switch to workspace
        "${mod}+quotedbl" = "workspace 1";
        "${mod}+guillemotleft" = "workspace 2";
        "${mod}+guillemotright" = "workspace 3";
        "${mod}+parenleft" = "workspace 4";
        "${mod}+parenright" = "workspace 5";
        "${mod}+at" = "workspace 6";
        "${mod}+plus" = "workspace 7";
        "${mod}+minus" = "workspace 8";
        "${mod}+slash" = "workspace 9";
        "${mod}+asterisk" = "workspace 10";

        # Cycling between workspaces
        "${mod}+Left" = "workspace prev";
        "${mod}+Right" = "workspace next";

        # move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "${mod}+Shift+6" = "move container to workspace 6";
        "${mod}+Shift+7" = "move container to workspace 7";
        "${mod}+Shift+8" = "move container to workspace 8";
        "${mod}+Shift+9" = "move container to workspace 9";
        "${mod}+Shift+0" = "move container to workspace 10";

        # Move worspaces to outputs
        "${mod}+Ctrl+Left" = "move workspace to output left";
        "${mod}+Ctrl+Right" = "move workspace to output right";
        # Same with vim-like bindings
        "${mod}+Ctrl+c" = "move workspace to output left";
        "${mod}+Ctrl+r" = "move workspace to output right";

        # Volume management
        "${mod}+Up" = "exec amixer -q set Master 2%+";
        "${mod}+Down" = "exec amixer -q set Master 2%-";
        "${mod}+m" = "exec amixer set Master toggle";

        # reload the configuration file
        "${mod}+Shift+X" = "reload";
        # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        "${mod}+Shift+O" = "restart";
        # exit i3 (logs you out of your X session)
        "${mod}+Shift+P" = "exit";

        # keymap transitions TODO: package this script
        "${mod}+F1" = "exec ${pkgs.keymap-switch}/bin/keymap-switch";
        "${mod}+F2" = "exec ${pkgs.keymap-switch}/bin/keymap-switch fr bepo";

        # screen lock
        "${mod}+l" = "exec ${pkgs.i3lock}/bin/i3lock -i ~/images/wallpapers/lock_wallpaper.png"; # TODO: handle the image path
        # lock but keep right screen on display
        "${mod}+Shift+L" = "exec ~/.i3/lock_show_all.zsh";

        "${mod}+o" = "mode \"resize\"";

        # Redshift and luminosity play
        "${mod}+Shift+F5" = "exec xbacklight -set 5";
        "${mod}+F5" = "exec xbacklight -set 30";
        "${mod}+F6" = "exec xbacklight -set 100";
        "${mod}+Shift+F6" = "exec xbacklight -set 0";
        "${mod}+F7" = "exec redshift -P -O 3000K";
        "${mod}+shift+F7" = "exec redshift -P -O 2000K";
        "${mod}+F8" = "exec redshift -P -O 6500K";

        # Python!
        "${mod}+j" = "exec \"${defaultTerminal} -e python\"";
        "${mod}+Shift+J" = "exec \"${defaultTerminal} -e ipython\"";
      };

      modes.resize = {
        # vim-like resizing
        "c" = "resize shrink width 5 px or 5 ppt";
        "t" = "resize grow height 5 px or 5 ppt";
        "s" = "resize shrink height 5 px or 5 ppt";
        "r" = "resize grow width 5 px or 5 ppt";

        # same bindings, but for the arrow keys
        Left = "resize shrink width 5 px or 5 ppt";
        Down = "resize grow height 5 px or 5 ppt";
        Up = "resize shrink height 5 px or 5 ppt";
        Right = "resize grow width 5 px or 5 ppt";

        # back to normal: Enter or Escape
        Return = "mode \"default\"";
        Escape = "mode \"default\"";
      };

      startup = [
        { command = "systemctl --user restart polybar"; always = true; notification = false; }
      ];

      bars = [ ] ;  # Bars handled by polybar
    };
  };
}
