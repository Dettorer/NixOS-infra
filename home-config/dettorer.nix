let
  my = import ../.;
in
{
  nixpkgs.overlays = [ my.pkgs ]; # Add my own custom packages
  imports = [
    ./alacritty.nix # TODO: not on server
    ./emacs.nix
    ./epita.nix
    ./neovim.nix
    ./mails.nix
    ./tmux.nix
    ./xsession.nix # TODO: not on server
    ./zsh.nix
  ];
}
