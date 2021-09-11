{ pkgs, ... }:

{
  # Tools for SYNVA work
  home.packages = with pkgs; [ my.via ]; # TODO: no via on server
}
