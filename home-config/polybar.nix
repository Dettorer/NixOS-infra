{ pkgs, ... }:

let
  # Decoration glyphs
  decor-glyph-common = {
    type = "custom/text";
    # content-background = 
    # content-foreground = 
  };

  bar-common = {
    height = 22;
    font = [
      "Iosevka Nerd Font:style=Medium:size=10;3" # Text Fonts
      "icomoon\\-feather:style=Medium:size=10;3" # Icons Fonts
      "Iosevka Nerd Font:style=Medium:size=16;3" # Powerline Glyphs
      "Iosevka Nerd Font:style=Medium:size=12;3" # Larger font size for bar fill icons
      "Iosevka Nerd Font:style=Medium:size=7;3" # Smaller font size for shorter spaces
      "Unifont Upper:pixelsize=12;1" # Extra symbols (like the train for magnet vpn)
    ];
  };

  module-padding = 1;
  bar-format = "%{T4}%fill%%indicator%%empty%%{F-}%{T-}";
  bar-fill-icon = "ﭳ";

  battery-common = {
    type = "internal/battery";
    full-at = 100;

    adapter = "ACAD";
    poll.interval = "2";

    time-format = "%Hh:%M";
    format.charging.text = "<animation-charging>  <label-charging>";
    # format.charging.background = "${color.mb}";
    format.charging.padding = module-padding;
    format.discharging.text = "<ramp-capacity>  <label-discharging>";
    # format.discharging.background = "${color.mb}";
    format.discharging.padding = module-padding;

    format.full.text = "<ramp-capacity>  <label-full>";
    # format-full-background = "${color.mb}";
    format.full.padding = module-padding;

    label.charging = "%percentage%%";
    label.discharging = "%percentage%%";
    label.full = "Fully charged";

    ramp.capacity = [ "" "" "" "" "" "" "" "" "" "" ];

    animation.charging.text = [ "" "" "" "" "" "" "" "" "" "" ];
    animation.charging.framerate = "500";

    animation.discharging.text = [ "" "" "" "" "" "" "" "" "" "" ];
    animation.discharging.framerate = "500";
  };

  network-common = {
    type = "internal/network";
    accumulate-stats = "true";
    unknown-as-up = "true";

    format.connected.text = "<ramp-signal> <label-connected>";
    # format.connected.background = "${color.mb}";
    format.connected.padding = module-padding;
    format.disconnected.text = "<label-disconnected>";
    # format.disconnected.background = "${color.mb}";
    format.disconnected.padding = module-padding;

    label.connected = "%essid% %downspeed:7% %upspeed:7%";
    label.disconnected = "";

    ramp-signal = [ "" "" "" "" "" ];
  };
in {
  xdg.dataFile."fonts/icomoon-feather.ttf".source = ./custom-fonts/icomoon-feather.ttf;

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
    };

    script = ''
      polybar top &
      polybar bottom &
    '';

    settings = {
      "global/wm" = {
        # margin-top = 0;
        # margin-bottom = 0;
      };

      # Decoration glyphs
      "module/right-end-top" = decor-glyph-common // {
        content = "%{T3} %{T-}";
      };
      "module/left-end-top" = decor-glyph-common // {
        content = "%{T3} %{T-}";
      };
      "module/right-end-bottom" = decor-glyph-common // {
        content = "%{T3} %{T-}";
      };
      "module/left-end-bottom" = decor-glyph-common // {
        content = "%{T3} %{T-}";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index.sort = true;
        wrapping.scroll = false;

        # Only show workspaces on the same output as the bar
        pin-workspaces = true;

        label-mode-padding = 2;
        # label-mode-foreground = #000;
        # label-mode-background = ${color.fg};

        # focused = Active workspace on focused monitor
        label.focused.text = "%index%";
        #label.focused.background = ${color.mb};
        label.focused.padding = 1;

        # unfocused = Inactive workspace on any monitor
        label-unfocused = "%index%";
        label-unfocused-padding = 1;

        # visible = Active workspace on unfocused monitor
        label-visible = "%index%";
        # label-visible-background = ${self.label-focused-background};
        # label-visible-padding = ${self.label-focused-padding};

        # urgent = Workspace with urgency hint set
        label-urgent = "%index%";
        # label-urgent-foreground = ${color.red}
        # label-urgent-background = #8CFF0000
        # label-urgent-padding = 1
      };

      "module/title" = {
        type = "internal/xwindow";
        format.text = "<label>";
        # format.background = ${color.mb}
        format-padding = module-padding;
        label.text = "%title%";
        label.maxlen = 50;
        label.empty.text = "Rivamar";
      };

      "module/temperature" = {
        type = "internal/temperature";

        format.text = "<ramp> <label>";
        # format.background = color.mb
        format.padding = module-padding;
        format.warn.text = "<ramp> <label-warn>";
        #format.warn.background = ${color.mb}
        format.warn.padding = module-padding;

        label.text = "%temperature-c%";
        label.warn.text = "%temperature-c%";
        # label.warn.foreground = "#f00"

        ramp = [ "" "" "" "" "" ];
      };

      "module/battery-int" = battery-common // {
        battery = "BAT0";
        label-charging = "%percentage%% (int)";
        label-discharging = "%percentage%% %time% (int)";
        label-full = "Full (int)";
      };

      "module/battery-ext" = battery-common // {
        battery = "BAT1";
        label-charging = "%percentage%% (ext)";
        label-discharging = "%percentage%% %time% (ext)";
        label-full = "Full (ext)";
      };

      "module/wired-network" = network-common // {
        interface = "enp0s31f6";  # TODO: factorize interface names
        label.connected = " (%linkspeed%) %local_ip% %downspeed:7% %upspeed:7%";
        format.connected = "<label-connected>";
        label.disconnected = "";
      };

      "module/magnet-network" = network-common // {
        interface = "tun0";  # TODO: factorize interface names
        label.connected = "🚝 magnet %local_ip%";
        format.connected = "<label-connected>";
        label.disconnected = "🚝 m̶a̶g̶n̶e̶t̶";
      };

      "module/wireless-network" = network-common // {
        interface = "wlp3s0";  # TODO: factorize interface names
        label.connected = "%essid% %local_ip% %downspeed:7% %upspeed:7%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = "0.5";
        format.text = "<label>";
        format.prefix = "";
        # format.background = "${color.mb}";
        format.padding = module-padding;
        label = " %percentage%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = "1.0";
        time.text = " %A %d-%m-%Y  %H:%M:%S";
        time.alt.text = " %H:%M";
        format = "<label>";
        # format-background = "${color.mb}";
        format-padding = module-padding;
        label = "%time%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = "3";
        format.text = "<label> <bar-used>";
        format.prefix = "";
        # format.background = "${color.mb}";
        format.padding = module-padding;
        label = " %mb_used%";
        bar.used.indicator = "";
        bar.used.width = "20";
        bar.used.foreground = [ "#55aa55" "#557755" "#f5a70a" "#ff5555" ];
        bar.used.fill = "▐";
        bar.used.empty.text = "▐";
        # bar.used.empty.foreground = "#444444";
      };

      "module/colors-switch" = { # TODO: remove? 
        type = "custom/text";
        content.text = "";
        # content.background = "${color.mb}";
        content.padding = module-padding;
        # click-left = "~/.config/polybar/scripts/color-switch.sh &";
        # click-right = "~/.config/polybar/scripts/color-switch.sh &";
      };

      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        interval = "10";
        fixed-values = "true";
        format-mounted.text = "<label-mounted>";
        format.mounted.prefix = "";
        # format.mounted.background = "${color.mb}";
        format.mounted.padding = module-padding;

        format.unmounted.text = "<label-unmounted>";
        format.unmounted.prefix = "";
        # format.unmounted.background = "${color.mb}";
        format.unmounted.padding = module-padding;

        label.mounted = " %percentage_used%% (%free% free)";
        label.unmounted = "%mountpoint%: not mounted";
      };

      "module/volume" = {
        type = "internal/alsa";

        format.volume.text = "<ramp-volume> <bar-volume> <label-volume>";
        # format.volume.background = "${color.mb}";
        format.volume.padding = module-padding;
        format.muted.text = "<label-muted>";
        format.muted.prefix = "";
        # format.muted.background = "${color.mb}";

        label.volume.text = "%percentage%%";
        label.muted.text = "Muted";
        # label.muted.foreground = "${color.ac}";
        # label.muted.background = "${color.mb}";
        label.muted.padding = module-padding;

        ramp-volume = [ "" "" "" "" "" "" ];

        bar-volume.format = bar-format;
        # bar-volume.foreground = [ "${color.bn}" "${color.bn}" "${color.bn}" "${color.bm}" "${color.bd}" "${color.bd}" ];

        bar-volume.width = "6";
        bar-volume.gradient = "false";
        bar-volume.fill = bar-fill-icon;
        bar-volume.indicator = "";
        bar-volume.empty.text = bar-fill-icon;
        # bar-volume.empty.foreground = "${color.be}";

        ramp-headphones = [ "" "" ];
      };

      "module/brightness" = {
        type = "internal/xbacklight";
        card = "intel_backlight";

        format.text = "<ramp> <bar>";
        # format.background = "${color.mb}";
        format.padding = module-padding;

        label = "%percentage%%";
        ramp = [ "" "" "" "" "" "" ];

        bar-format = bar-format;
        # bar-foreground = [ "${color.bd}" "${color.bd}" "${color.bd}" "${color.bm}" "${color.bf}" "${color.bf}" ];

        bar-width = "6";
        bar-gradient = "false";
        bar-fill = bar-fill-icon;
        bar-indicator = "";
        bar-empty = bar-fill-icon;
        # bar-empty-foreground = "${color.be}";
      };

      "module/sysmenu" = {
        type = "custom/text";
        content.text = "";
        # content.background = "${color.mb}";
        # content.foreground = "${color.mf}";
        content.padding = module-padding;
        # click-left = "~/.config/polybar/scripts/powermenu"; # TODO: package the script
        # click-right = "~/.config/polybar/scripts/powermenu-alt"; # TODO: same
      };

      "module/updates" = {
        type = "custom/script";
        # exec = "~/.config/polybar/scripts/updates.sh"; # TODO: package the script
        tail = true;
        interval = 5;
        # format-background = "${color.mb}";
        format-padding = module-padding;
        # click-left = "~/.config/polybar/scripts/lupdates &"; # TODO: package the script
      };

      "bar/top" = bar-common // {
        enable-ipc = true;
        monitor = "eDP-1";  # TODO: factorize screen names
        modules.left = "colors-switch right-end-top i3";
        modules.center = "left-end-top title right-end-top";
        modules.right = "left-end-top xkeyboard-short right-end-bottom left-end-top updates right-end-bottom left-end-top battery-int battery-ext right-end-bottom left-end-top date sysmenu";
      };

      "bar/bottom" = bar-common // {
        monitor = "eDP-1";  # TODO: factorize screen names
        bottom = true;

        modules.left = "right-end-bottom left-end-top temperature cpu memory right-end-bottom left-end-top filesystem right-end-bottom ";
        modules.right = "left-end-bottom wired-network right-end-top left-end-bottom wireless-network right-end-top left-end-bottom magnet-network right-end-top left-end-bottom volume brightness";

        enable-ipc = true;
        tray-position = "left";
        # "tray-background" =
        };
      };
    };
  }
