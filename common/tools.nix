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
    "pentablet-driver"
  ];

  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: [ ps.ipython ]))
    alacritty.terminfo
    emacs
    file
    git
    most
    ocaml
    pdftk
    tree
    unzip
    wget
    zsh

    # monitoring
    htop
    nmon
    smartmontools
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

  # Needed for an obscure reason for via (video-conferencing application for
  # SYNVA)
  services.upower.enable = true;
}
