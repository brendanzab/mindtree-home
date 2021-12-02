# A collection of packages to be included with the `cli.nix` module that act as
# aliases for commonly used `nix-shell` environments. These act as pure
# alternatives to bash aliases.
#
# TODO: Simplify this by investigating how do this automatically for all
# `./*-dev.nix` files, rather than doing each manually.
{ pkgs, ... }:
let
  idris-dev-pkg = { writeShellScriptBin, ... }:
    writeShellScriptBin "idris-dev" "nix-shell ${./idris-dev.nix}";
  rust-dev-pkg = { writeShellScriptBin, ... }:
  writeShellScriptBin "rust-dev" ''
    nix-shell -E "(import ${./rust-dev.nix}) { rustChannel = rust-bin: rust-bin.stable.latest; }"
  '';
  rust-nightly-dev-pkg = { writeShellScriptBin, ... }:
  writeShellScriptBin "rust-nightly-dev" ''
    nix-shell -E "(import ${./rust-dev.nix}) { rustChannel = rust-bin: rust-bin.nightly.latest; }"
  '';
  stlink-dev-pkg = { writeShellScriptBin, ... }:
    writeShellScriptBin "stlink-dev" "nix-shell ${./stlink-dev.nix}";
  teensy4-rs-dev-pkg = { writeShellScriptBin, ... }:
    writeShellScriptBin "teensy4-rs-dev" "nix-shell ${./teensy4-rs-dev.nix}";

  idris-alias-pkg = { idris2, writeShellScriptBin, ... }:
    writeShellScriptBin "idris" ''
      ${idris2}/bin/idris2 "$@"
    '';

  # Alias packages.
  idris-alias = pkgs.callPackage idris-alias-pkg {};
  idris-dev = pkgs.callPackage idris-dev-pkg {};
  rust-dev = pkgs.callPackage rust-dev-pkg {};
  rust-nightly-dev = pkgs.callPackage rust-nightly-dev-pkg {};
  stlink-dev = pkgs.callPackage stlink-dev-pkg {};
  teensy4-rs-dev = pkgs.callPackage teensy4-rs-dev-pkg {};

in {
  home.packages = [
    idris-alias
    idris-dev
    rust-dev
    rust-nightly-dev
    stlink-dev
    teensy4-rs-dev
  ];
}
