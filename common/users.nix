{ pkgs, ... }:

{
  users.users.dettorer = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "libvirtd"
      "lp"
      "scanner"
      "users"
      "vboxusers"
      "video"
      "wheel"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.dettorer = import ../home-config/dettorer.nix;
  };
}
