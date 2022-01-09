{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation {
  name = "idris-dev";
  buildInputs = [
    idris2
  ];
}
