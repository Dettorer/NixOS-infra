{ pkgs, lib, ... }:

{
  imports = [ ./i3.nix ];

  home.keyboard = {
    layout = "fr";
    variant = "bepo";
    options = [ "caps:swapescape" ];
  };

  xsession = {
    enable = true;
    numlock.enable = true;
    initExtra = ''
      ${pkgs.nitrogen}/bin/nitrogen --restore
    '';
  };
}
