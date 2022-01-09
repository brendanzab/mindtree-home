# For cross-compiling coreaudio crates to macOS from Linux.
{ pkgs, ... }:
with pkgs;
let
  macosx-sdk = callPackage ./macosx-sdk.nix {};
in
  stdenv.mkDerivation {
    name = "coreaudio-dev";
    buildInputs = [
      llvmPackages.libclang
      macosx-sdk
    ];
    COREAUDIO_SDK_PATH = "${macosx-sdk}/MacOSX10.13.sdk";
    LIBCLANG_PATH = "${llvmPackages.libclang}/lib";
  }
