{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    historyLimit = 100000;
    extraConfig = ''
      # Set the tmux status bar color
      set -g default-terminal "screen-256color"
      set-option -g status-style bg=default
      set-option -g status-style fg=default
    '';
  };
}
