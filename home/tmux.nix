{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    historyLimit = 100000;
    extraConfig = ''
      # Set the tmux status bar color
      set -g default-terminal "screen-256color"
      set -g status-bg default
      set -g status-fg white
    '';
  };
}
