{ config, lib, pkgs, ... }: {
  options.mindtree.de.gnome-terminal = {
    enable = lib.mkEnableOption "Custom GNOME Terminal configuration.";
  };
  config = lib.mkIf config.mindtree.de.gnome-terminal.enable {
    programs.gnome-terminal = {
      enable = true;
      profile = {
        mindtree = {
          default = true;
          visibleName = "mindtree";
          showScrollbar = false;
        };
      };
    };
  };
}

# TO-ADD: Currently home-manager doesn't allow to have both a custom palette
# and theme colours for the rest of the terminal. If it ever does, add these.
#
# Palette (in order of entries):
#
# #171421
# #C01C28
# #26A269
# #A2734C
# #12488B
# #727272
# #2AA1B3
# #D0CFCC
# #5E5C64
# #F66151
# #33DA7A
# #E9AD0C
# #2A7BDE
# #C061CB
# #33C7DE
# #FFFFFF
