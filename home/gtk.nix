{ config, lib, pkgs, ... }: {
  options.mindtree.de.gtk = {
    enable = lib.mkEnableOption "Custom GTK configuration.";
  };
  config = lib.mkIf config.mindtree.de.gtk.enable {
    gtk = {
      enable = true;
      theme.name = "Adwaita-dark";
    };
  };
}
