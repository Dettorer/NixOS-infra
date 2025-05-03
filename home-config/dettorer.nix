let
  my = import ../.;
in
{
  home.stateVersion = "21.05";

  imports = [
    ./alacritty.nix # TODO: not on server
    ./emacs.nix
    ./git.nix
    ./kitty.nix # TODO: not on server
    ./mails.nix
    ./neovim.nix
    ./ssh.nix
    ./tmux.nix
    ./vscode.nix
    ./xsession.nix # TODO: not on server
    ./zsh.nix
  ];
}
