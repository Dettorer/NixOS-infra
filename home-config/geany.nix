{ pkgs, ... }:

let
  plugin = pkgs.geany-plugin-m68k;
in
{
  home.packages = [ pkgs.geany ];
  home.file."68000" = {
    source = "${plugin}/68000";
    recursive = true;
  };
  xdg.configFile."geany/filedefs/filetypes.asm".source = "${plugin}/editor/filetypes.asm";
}
