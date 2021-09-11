{ config, lib, pkgs, ... }:

let
  cfg = config.my.roles.nix-builder;
in {
  options.my.roles.nix-builder = {
    enable = lib.mkEnableOption "Nix builder";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ morph ];
  };
}
