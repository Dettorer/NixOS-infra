let
  my = import ../.;
in
{
  home.stateVersion = "21.05";

  imports = [
    ./alacritty.nix # TODO: not on server
    ./emacs.nix
    ./epita.nix
    ./git.nix
    ./mails.nix
    ./neovim.nix
    ./ssh.nix
    ./tmux.nix
    ./xsession.nix # TODO: not on server
    ./zsh.nix
  ];
}
