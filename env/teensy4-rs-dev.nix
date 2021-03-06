# An expression producing an environment suitable for rust & nannou dev.
{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation {
  name = "teensy4-rs-dev-env";
  buildInputs = [
    binutils
    gcc-arm-embedded
    jq
    openocd # On-Chip Debugging
    teensy-loader-cli
  ];
}
