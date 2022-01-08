{ config, lib, pkgs, ... }: {
  options.mindtree.de.audio = {
    enable = lib.mkEnableOption "Audio stuff.";
  };
  config = lib.mkIf config.mindtree.de.audio.enable {
    home.packages = with pkgs; [
      (ardour.override { videoSupport = true; })
      calf
      carla
      geonkick
      helm
      lsp-plugins
      mixxx # DJ mixer
      noise-repellent
      paulstretch
      # puredata
      qjackctl
      sfizz # sfz sampler
      # supercollider
      surge
      swh_lv2
      vmpk # virtual midi keyboard
      x42-avldrums
      x42-gmsynth
      x42-plugins
      zam-plugins # Some random plugins I'm about to try
      zynaddsubfx # Plugin

      # Remove this in favour of `puredata` above once the
      # `fix-jack-client-name-len` patch is merged into the pure data, is
      # published in a new version and the new version is available in nixpkgs.
      # (callPackage /home/mindtree/programming/nix/puredata/puredata.nix {})
    ];
  };
}
