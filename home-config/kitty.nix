{ pkgs, ... }:

let
  my = import ../.;
  hints_alphabet = "tesirunac,vodpljb";
  font_size_increment = "0.5";
in
{
  programs.kitty = {
    # TODO: adapt the invert_colors script for kitty
    enable = true;

    theme = "One Half Dark";

    font.name = "DejaVu Sans Mono";
    font.size = 10; # TODO: 10 on desktop

    shellIntegration.mode = "no-cursor";

    settings = {
      "adjust_baseline" = 1;
      "adjust_column_width" = 0;
      "background" = "#121317";
      "background_opacity" = "0.97";
      "box_drawing_scale" = "0.001, 1, 1.5, 2";
      "cursor_blink_interval" = 0;
      "dim_opacity" = "0.75";
      "enable_audio_bell" = false;
      "force_ltr" = false;
      "paste_actions" = "quote-urls-at-prompt,confirm";
      "placement_strategy" = "top-left";
      "scrollback_lines" = 10000;
      "scrollback_pager" = "most";
      "strip_trailing_spaces" = "always";
      "text_composition_strategy" = "legacy";
      "visual_window_select_characters" = hints_alphabet;
    };

    keybindings = {
      # url hints
      "alt+u"       = "kitten hints --hints-offset=0 --alphabet=${hints_alphabet} --hints-text-color=green";
      "kitty_mod+e" = "kitten hints --hints-offset=0 --alphabet=${hints_alphabet} --hints-text-color=green";

      # Increase font size
      "cmd+plus"              = "change_font_size all +${font_size_increment}";
      "kitty_mod+kp_add"      = "change_font_size all +${font_size_increment}";
      "kitty_mod+plus"        = "change_font_size all +${font_size_increment}";
      "shift+cmd+equal"       = "change_font_size all +${font_size_increment}";
      # Decrease font size
      "cmd+minus"             = "change_font_size all -${font_size_increment}";
      "kitty_mod+kp_subtract" = "change_font_size all -${font_size_increment}";
      "kitty_mod+minus"       = "change_font_size all -${font_size_increment}";
      "shift+cmd+minus"       = "change_font_size all -${font_size_increment}";
      # Reset font size
      "ctrl+0"                = "change_font_size all 0";
      "ctrl+equal"            = "change_font_size all 0";
      "kitty_mod+backspace"   = "change_font_size all 0";
      "kitty_mod+equal"       = "change_font_size all 0";
    };
  };
}
