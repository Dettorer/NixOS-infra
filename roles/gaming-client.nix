{ config, lib, pkgs, ... }:

let
  cfg = config.my.roles.gaming-client;
in {
  options.my.roles.gaming-client = {
    enable = lib.mkEnableOption "Gaming client";
  };

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
    programs.steam.remotePlay.openFirewall = true;
  };
}
