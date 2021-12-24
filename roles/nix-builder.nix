{ config, lib, pkgs, ... }:

let
  cfg = config.my.roles.nix-builder;
in {
  options.my.roles.nix-builder = {
    enable = lib.mkEnableOption "Nix builder";
  };

  config = lib.mkIf cfg.enable {
    # TODO: remove morph when confident with the new flake workeflow
    environment.systemPackages = with pkgs; [ morph ];
  };
}
