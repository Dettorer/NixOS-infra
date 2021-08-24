{ pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager.git";
    ref = "release-21.05";
  };
in
{
  users.users.dettorer = {
    isNormalUser = true;
    extraGroups = [ "users" "wheel" "networkmanager" "scanner" "lp" ];
  };

  imports = [ (import "${home-manager}/nixos") ];
  home-manager.users.dettorer = import ../home-config/dettorer.nix;
}
