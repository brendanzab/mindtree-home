# A collection of packages to be included with the `cli.nix` module that act as
# aliases for commonly used `nix-shell` environments. These act as pure
# alternatives to bash aliases.
#
# TODO: Simplify this by investigating how do this automatically for all
# `./*-dev.nix` files, rather than doing each manually.
{ pkgs, ... }:
let
  # Derivations.
  rust-dev-pkg = { writeShellScriptBin, ... }:
    writeShellScriptBin "rust-dev" "nix-shell ${./rust-dev.nix}";
  stlink-dev-pkg = { writeShellScriptBin, ... }:
    writeShellScriptBin "stlink-dev" "nix-shell ${./stlink-dev.nix}";
  teensy4-rs-dev-pkg = { writeShellScriptBin, ... }:
    writeShellScriptBin "teensy4-rs-dev" "nix-shell ${./teensy4-rs-dev.nix}";

  # Alias packages.
  rust-dev = pkgs.callPackage rust-dev-pkg {};
  stlink-dev = pkgs.callPackage stlink-dev-pkg {};
  teensy4-rs-dev = pkgs.callPackage teensy4-rs-dev-pkg {};
in {
  home.packages = with pkgs; [
    rust-dev
    stlink-dev
    teensy4-rs-dev
  ];
}
