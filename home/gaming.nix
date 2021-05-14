{ config, lib, pkgs, ... }: {
  options.mindtree.de.gaming = {
    enable = lib.mkEnableOption "Gaming and related packages.";
  };
  config = lib.mkIf config.mindtree.de.gaming.enable {
    home.packages = with pkgs; [
      cataclysm-dda
      faudio # DirectX audio wrapper for skyrim
      lutris
      minecraft
      protontricks
      wine-staging # For testing `auracle` sound card control software from iConnectivity.
      zeroad
    ];
  };
}
