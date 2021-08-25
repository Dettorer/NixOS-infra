{ config, lib, pkgs, ... }:

let
  cfg = config.my.roles.printing;
in {
  options.my.roles.printing = {
    enable = lib.mkEnableOption "Printers handling";
  };

  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = [ pkgs.cnijfilter_4_00 ];
    };
    hardware.sane = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      ghostscript
    ];
  };
}
