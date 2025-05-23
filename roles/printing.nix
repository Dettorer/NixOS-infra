{ config, lib, pkgs, ... }:

let cfg = config.my.roles.printing;
in {
  options.my.roles.printing = {
    enable = lib.mkEnableOption "Printers handling";
  };

  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = with pkgs; [ cnijfilter_4_00 epson-escpr epson-escpr2 ];
    };
    hardware.sane = { enable = true; };

    environment.systemPackages = with pkgs; [ ghostscript ];
  };
}
