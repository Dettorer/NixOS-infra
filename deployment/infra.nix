let
  pkgs = import <nixpkgs> {};
in
{
  network.descrption = "*.dettorer.net infra";

  "rivamar.home" = import ../machines/rivamar;
}
