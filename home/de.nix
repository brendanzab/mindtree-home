# Top-level expression for inclusion in
# `/home/mindtree/.config/nixpkgs/home.nix`
{ config, lib, pkgs, ... }:
let
  cfg = config.mindtree.de;
in {
  imports = [
    ./audio.nix
    ./firefox.nix
    ./gaming.nix
    ./gnome-terminal.nix
    ./gtk.nix
    #./teensyduino.nix
  ];

  options.mindtree.de = {
    enable = lib.mkEnableOption ''
      Whether or not to enable the desktop environment.
      Should remain `false` for headless environments.
    '';

    permittedInsecurePkgNames = lib.mkOption {
      description = "The names of all vetted insecure packages.";
      type = lib.types.listOf lib.types.str;
      default = [
        # Required for obinskit.
        "electron-3.1.13"
        # Required for zeroad.
        "spidermonkey-38.8.0"
      ];
    };

    unfreePkgNames = lib.mkOption {
      description = "The names of all vetted unfree packages.";
      type = lib.types.listOf lib.types.str;
      default = [
        "minecraft-launcher"
        "obinskit"
        "soulseekqt"
        "spotify"
        "spotify-unwrapped"
        "steam"
        "steam-original"
        "steam-runtime"
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    # Packages without any special config.
    home.packages = with pkgs; [
      arduino
      bitwarden
      # blender
      deluge
      gimp
      gnome3.adwaita-icon-theme
      gnome3.gnome-bluetooth
      gnome3.gnome-power-manager
      gnome3.gnome-todo
      gnome3.gnome-tweak-tool
      gnomeExtensions.gsconnect
      gst_all_1.gst-libav # trying to get AIFF files working in nautilus preview
      gst_all_1.gst-plugins-bad # trying to get AIFF files working in nautilus preview
      inkscape
      kicad
      libreoffice
      nmap-graphical
      obinskit # Anne Pro 2 configuration.
      signal-desktop
      soulseekqt
      spotify
      steam-run
      sysprof
      vlc
      wireshark
    ];
    mindtree.de.audio.enable = lib.mkDefault true;
    mindtree.de.firefox.enable = lib.mkDefault true;
    mindtree.de.gaming.enable = lib.mkDefault true;
    mindtree.de.gnome-terminal.enable = lib.mkDefault true;
    mindtree.de.gtk.enable = lib.mkDefault true;
  };
}
