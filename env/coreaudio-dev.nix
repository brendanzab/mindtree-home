# For cross-compiling coreaudio crates to macOS from Linux.
with import <nixpkgs> {};
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
