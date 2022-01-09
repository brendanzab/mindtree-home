{ inputs, system }:
let
  pkgs = import inputs.nixpkgs { inherit system; };
  rust-pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ (import inputs.rust-overlay) ];
  };
in {
  # The set of shells to provide to the flake's `devShells` attribute.
  # This enables dropping into dev environments with `nix develop .#<*-dev>`
  devShells = {
    blethrs-dev = import ./blethrs-dev.nix { inherit pkgs; };
    coreaudio-dev = import ./coreaudio-dev.nix { inherit pkgs; };
    idris-dev = import ./idris-dev.nix { inherit pkgs; };
    rust-dev = import ./rust-dev.nix {
      pkgs = rust-pkgs;
      rustChannel = rust-bin: rust-bin.stable.latest;
    };
    rust-nightly-dev = import ./rust-dev.nix {
      pkgs = rust-pkgs;
      rustChannel = rust-bin: rust-bin.nightly.latest;
    };
    stlink-dev = import ./stlink-dev.nix { inherit pkgs; };
    teensy4-rs-dev = import ./teensy4-rs-dev.nix { inherit pkgs; };
  };

  # A set of packages that act as aliases providing easy access to the
  # `devShells`.
  devShellAliases = let
    # Short-hand scripts.
    blethrs-dev-pkg = { writeShellScriptBin, ... }:
      writeShellScriptBin "blethrs-dev" "nix develop ${inputs.self}#blethrs-dev";
    coreaudio-dev-pkg = { writeShellScriptBin, ... }:
      writeShellScriptBin "coreaudio-dev" "nix develop ${inputs.self}#coreaudio-dev";
    idris-dev-pkg = { writeShellScriptBin, ... }:
      writeShellScriptBin "idris-dev" "nix develop ${inputs.self}#idris-dev";
    rust-dev-pkg = { writeShellScriptBin, ... }:
      writeShellScriptBin "rust-dev" "nix develop ${inputs.self}#rust-dev";
    rust-nightly-dev-pkg = { writeShellScriptBin, ... }:
      writeShellScriptBin "rust-nightly-dev" "nix develop ${inputs.self}#rust-nightly-dev";
    stlink-dev-pkg = { writeShellScriptBin, ... }:
      writeShellScriptBin "stlink-dev" "nix develop ${inputs.self}#stlink-dev";
    teensy4-rs-dev-pkg = { writeShellScriptBin, ... }:
      writeShellScriptBin "teensy4-rs-dev" "nix develop ${inputs.self}#teensy4-rs-dev";
    # Script pkgs.
    blethrs-dev = pkgs.callPackage blethrs-dev-pkg {};
    coreaudio-dev = pkgs.callPackage coreaudio-dev-pkg {};
    idris-dev = pkgs.callPackage idris-dev-pkg {};
    rust-dev = pkgs.callPackage rust-dev-pkg {};
    rust-nightly-dev = pkgs.callPackage rust-nightly-dev-pkg {};
    stlink-dev = pkgs.callPackage stlink-dev-pkg {};
    teensy4-rs-dev = pkgs.callPackage teensy4-rs-dev-pkg {};
  in {
    home.packages = [
      blethrs-dev
      coreaudio-dev
      idris-dev
      rust-dev
      rust-nightly-dev
      stlink-dev
      teensy4-rs-dev
    ];
  };
}
