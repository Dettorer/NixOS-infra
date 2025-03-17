{ pkgs, lib, ... }:

{
  imports = [ ./i3.nix ];

  # 2025-03-17: rustdesk fails to build, and I don't really use it right now
  # home.packages = [ pkgs.rustdesk ];

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
