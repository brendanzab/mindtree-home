# Allows for using the original blethrs python bootloader.
# Kind of redundant since making `blethrs-link` - a pure-rust alternative.

{ pkgs }:
with pkgs;
let
  blethrs-python-pkgs = python-packages: with python-packages; [
    crcmod
    tqdm
  ];
  blethrs-python = python3.withPackages blethrs-python-pkgs;
in
  stdenv.mkDerivation {
    name = "blethrs-dev";
    buildInputs = [
      blethrs-python
    ];
  }
