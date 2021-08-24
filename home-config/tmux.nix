{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    clock24 = true;
    escapeTime = 20;
    historyLimit = 3000;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    plugins = [{
      plugin = pkgs.tmuxPlugins.onedark-theme;
      extraConfig = ''set -g @onedark_widgets "/: #(df -h | grep vda1 | cut -d' ' -f14) (#(df -h | grep vda1 | cut -d' ' -f12) free)"'';
    }];

    extraConfig = ''
      # Bindings
      bind-key C-b last-window

      # Rebind split
      unbind %
      bind | split-window -h
      bind - split-window -v

      # Truecolor: tmux only supports it if the external terminal has the "Tc"
      # (unofficial) or "RGB" (official) terminfo attribute, but my terminals'
      # terminfo don't seem to have either even though they support truecolor.
      # Here I tell tmux to add the "RGB" attribute itself to the external
      # terminal (and thus consider it truecolor-capable) if it matches
      # "alacritty" or "xterm-256color".
      # - alacritty because it's my default terminal
      # - xterm-256color because that's what mosh sets TERM to
      set -as terminal-features ",alacritty:RGB,xterm-256color:RGB"

      # Locking
      set-option -g lock-after-time 0
      set-option -g lock-command "vlock"
      bind-key C-x lock
    '';
  };
}
