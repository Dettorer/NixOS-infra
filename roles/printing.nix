{ config, lib, pkgs, ... }:

let cfg = config.my.roles.printing;
in {
  options.my.roles.printing = {
    enable = lib.mkEnableOption "Printers handling";
  };

  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = builtins.trace
        "WARN: printer unusable: I commented cnijfilter_4_00 out because it didn't build at the time"
        (with pkgs; [
          # cnijfilter_4_00
          epson-escpr
          epson-escpr2
        ]);
    };
    hardware.sane = { enable = true; };

    environment.systemPackages = with pkgs; [ ghostscript ];
  };
}
