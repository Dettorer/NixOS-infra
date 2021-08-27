{ pkgs, ... }:

let
  my = import ../.;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = my.colorschemes.OneHalfDark;
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
