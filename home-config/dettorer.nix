let
  my = import ../.;
in
{
  imports = [
    ./alacritty.nix # TODO: not on server
    ./emacs.nix
    ./epita.nix
    ./git.nix
    ./mails.nix
    ./neovim.nix
    ./ssh.nix
    ./synva.nix
    ./tmux.nix
    ./xsession.nix # TODO: not on server
    ./zsh.nix
  ];
}
