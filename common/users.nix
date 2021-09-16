{ pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager.git";
    ref = "master";
  };
in
{
  users.users.dettorer = {
    isNormalUser = true;
    extraGroups = [
      "libvirtd"
      "lp"
      "scanner"
      "users"
      "vboxusers"
      "video"
      "wheel"
    ];
  };

  imports = [ (import "${home-manager}/nixos") ];
  home-manager.users.dettorer = import ../home-config/dettorer.nix;
}
