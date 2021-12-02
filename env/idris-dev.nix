with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "idris-dev";
  buildInputs = [
    idris2
  ];
}
