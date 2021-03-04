# An expression producing an environment suitable for npm dev.
with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "node-js-dev-env";
  buildInputs = [
    nodejs
  ];
}
