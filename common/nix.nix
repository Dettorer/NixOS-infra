{ lib, pkgs, ... }:

let
  my = import ../.;
in
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    autoOptimiseStore = true;
    trustedUsers = [ "@wheel" ];
    gc.automatic = true;
    gc.options = lib.mkDefault "--delete-older-than 14d";
  };
  nixpkgs.overlays = [ my.pkgs ]; # Add my own custom packages

  # Pass secrets to other modules as parameter
  _module.args.secrets = my.secrets;
}
