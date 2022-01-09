{ config, lib, pkgs, ... }:
let
  cfg = config.mindtree.cli;
in {
  imports = [
    ./bash.nix
    #../env/aliases.nix
    ./git.nix
    ./tmux.nix
    ./vim/vim.nix
  ];

  options.mindtree.cli = {
    unfreePkgNames = lib.mkOption {
      description = "The names of all vetted unfree packages.";
      type = lib.types.listOf lib.types.str;
      default = [
        "unrar"
      ];
    };
  };

  config = {
    home = {
      packages = with pkgs; [
        ffmpeg
        gdb
        glxinfo
        graphviz
        ipfs
        libva-utils
        morph # Lighter, declarative alternative to nixops for deployment.
        netcat # For sending basic TCP packets.
        nodejs
        pciutils # Provides lspci - added to debug wifi not working
        platformio # For running daniel's arduino sketch for morph power supply mgmt.
        protonvpn-cli
        screen # to login to chip via serial
        sysbench
        tree
        unrar
        usbutils # lsusb
        vulkan-tools
        wget
        whois
      ];

      # Add some dirs to PATH.
      sessionPath = [
        "~/.cargo/bin"
      ];

      # ENV vars that should always be present.
      sessionVariables = {
        EDITOR = "${config.home.sessionVariables.VISUAL}";
        VISUAL = "vim";

        # Plugin paths.
        DSSI_PATH   = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
        LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
        LV2_PATH    = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
        LXVST_PATH  = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
        VST_PATH    = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
        VST3_PATH   = "$HOME/.vst3:$HOME/.nix-profile/lib/vst3:/run/current-system/sw/lib/vst3";
      };
    };
  };
}
