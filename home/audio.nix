{ config, lib, pkgs, ... }: {
  options.mindtree.de.audio = {
    enable = lib.mkEnableOption "Audio stuff.";
  };
  config = lib.mkIf config.mindtree.de.audio.enable {
    home.packages = with pkgs; [
      ardour
      calf
      helm
      lsp-plugins
      mixxx # DJ mixer
      noise-repellent
      paulstretch
      sfizz # sfz sampler
      supercollider
      surge
      swh_lv2
      x42-avldrums
      x42-gmsynth
      x42-plugins
      zam-plugins # Some random plugins I'm about to try
      zynaddsubfx # Plugin

      # TODO:
      # switch to `(ardour.override { videoSupport = true; })` when it lands in
      # nixpkgs.
      (callPackage /home/mindtree/programming/nix/harvid/harvid.nix {})
      (callPackage /home/mindtree/programming/nix/xjadeo/xjadeo.nix {})
      #(callPackage /home/mindtree/programming/nix/vital-bin/vital.nix {})
      (callPackage /home/mindtree/programming/nix/distrho-ports-master/distrho-ports-master.nix {})
    ];
  };
}
