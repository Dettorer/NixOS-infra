{ pkgs, ... }:

{
  # Tools for SYNVA work
  home.packages = with pkgs; [
    _my.via # TODO: no via on server
  ];
}
