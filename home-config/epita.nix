{ pkgs, ... }:

{
  # Tools for EPITA work
  home.packages = with pkgs; [ _my.geany-epita ]; # TODO: no geany on server
}
