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
    most
    wget
    zsh
    alacritty.terminfo
    tree
    git
    pdftk
    file
  ];

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
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
