{ pkgs, lib, ... }:

let
  my = import ../.;
in
rec {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "nvidia-x11" "nvidia-settings"
    "teams"
    "discord"
    "steam" "steam-original" "steam-runtime"
    "cnijfilter"
    "corefonts"
  ];

  environment.systemPackages = with pkgs; [
    alacritty.terminfo
    bat
    cachix
    emacs
    file
    imagemagick
    killall
    most
    ntfs3g
    pdftk
    tree
    unzip
    wget
    zip
    zsh

    # monitoring
    htop
    nmon
    smartmontools

    # development
    (python3.withPackages (ps: [ ps.ipython ]))
    cargo
    clang
    clang-tools
    gcc
    git
    ocaml
    pandoc
    texlive.combined.scheme-small
  ];

  programs.iftop.enable = true;

  environment.variables = {
    PAGER = "${pkgs.most}/bin/most";
  };

  # To enable zsh completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.mosh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services.locate.enable = true;
}
