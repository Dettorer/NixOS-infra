let
  my = import ../.;
in
{
  nixpkgs.overlays = [ my.pkgs ]; # Add my own custom packages
  imports = [
    ./neovim.nix
    ./emacs.nix
    ./zsh.nix
    ./tmux.nix
    ./xsession.nix # TODO: not on server
    ./alacritty.nix # TODO: not on server
    ./epita.nix
  ];
}
