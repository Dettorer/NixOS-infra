{ pkgs, ... }:

let
  # TODO: factorize colors across the whole nixos config
  OneHalfDark = {
    primary = {
      background = "0x121317";
      foreground = "0xdcdfe4";
    };

    normal = {
      black = "0x282c34";
      red = "0xe06c75";
      green = "0x98c379";
      yellow = "0xe5c07b";
      blue = "0x61afef";
      magenta = "0xc678dd";
      cyan = "0x56b6c2";
      white = "0xdcdfe4";
    };

    bright = {
      black = "0x282c34";
      red = "0xe06c75";
      green = "0x98c379";
      yellow = "0xe5c07b";
      blue = "0x61afef";
      magenta = "0xc678dd";
      cyan = "0x56b6c2";
      white = "0xdcdfe4";
    };
  };
  OneHalfLight = {
    primary = {
      background = "0xfafafa";
      foreground = "0x383a42";
    };
    normal = {
      black = "0x383a42";
      red = "0xe45649";
      green = "0x50a14f";
      yellow = "0xc18401";
      blue = "0x0184bc";
      magenta = "0xa626a4";
      cyan = "0x0997b3";
      white = "0xfafafa";
    };
    bright = {
      black = "0x383a42";
      red = "0xe45649";
      green = "0x50a14f";
      yellow = "0xc18401";
      blue = "0x0184bc";
      magenta = "0xa626a4";
      cyan = "0x0997b3";
      white = "0xfafafa";
    };
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = OneHalfDark;
      background_opacity = 0.97;

      font.normal.family = "DejaVu Sans Mono Nerd Font";
      font.size = 6; # TODO: 6 on laptop, 9.5 on desktop

      hints = { # detect and allow opening urls
        alphabet = "tesirunac,vodpléjb";
        enabled = [ {
          regex = ''(mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001F\u007F-\u009F<>" {-}\\^⟨⟩`]+'';
          command = "${pkgs.xdg-utils}/bin/xdg-open";
          post_processing = true;
          mouse.enable = true;
          mouse.mods = "None";
          binding.key = "U";
          binding.mods = "Alt";
        }];
      };

      key_bindings = [
        { key = "Equals"; mods = "Control"; action = "ResetFontSize"; }
        {
          key = "Key1";
          mods = "Control|Shift";
          command = { program = "invert_colors.sh"; args = []; }; # TODO: a script might not even work since nixos generated config files should not be modified, maybe find a way using escape sequences?
        }
      ];
    };
  };
}
