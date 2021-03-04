with import <nixpkgs> {};
let
  idris2 = callPackage ./idris2.nix {};
in
  stdenv.mkDerivation {
    name = "idris-dev";
    buildInputs = [
      idris2
    ];
  }
