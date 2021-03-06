# Common libraries, imported by other modules as "my"
rec {
  pkgs = import ./my-packages;

  common = import ./common;
  roles = import ./roles;
  secrets = import ./secrets.nix;
  colorschemes = import ./colorschemes.nix;

  modules = {
    imports = [
      common
      roles
      secrets.roles
    ];
  };
}
