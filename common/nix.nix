{ lib, pkgs, ... }:

let
  my = import ../.;
in
{
  nix = {
    package = pkgs.lix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc.automatic = true;
    gc.options = lib.mkDefault "--delete-older-than 14d";
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "@wheel" ];
    };
  };

  nixpkgs.overlays = [ my.pkgs ]; # Add my own custom packages

  # Pass secrets to other modules as parameter
  _module.args.secrets = my.secrets;
}
