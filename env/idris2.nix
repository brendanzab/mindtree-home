# Taken from here https://github.com/wchresta/idris2.nix/blob/master/idris2.nix
{ stdenv, fetchFromGitHub, makeWrapper, clang, chez }:
stdenv.mkDerivation {
  name = "idris2";
  src = fetchFromGitHub {
    owner = "idris-lang";
    repo = "Idris2";
    rev = "2005269c007ee7f5a75d0e17c3c4d552f4031524";
    sha256 = "1phr8bwcchkmr680dq4s8nmmcm3820gkfimlxw1vz7w80ilcr148";
  };
  strictDeps = true;
  nativeBuildInputs = [ makeWrapper clang chez ];
  buildInputs = [ chez ];
  prePatch = ''
    patchShebangs --build tests
    # Do not run tests as part of the build process
    substituteInPlace bootstrap.sh --replace "make test" "# make test"
  '';
  makeFlags = [ "PREFIX=$(out)" ];
  buildFlags = [ "bootstrap" "SCHEME=scheme" ];
  postInstall = ''
    wrapProgram "$out/bin/idris2" --prefix PATH : "${chez}/bin"
  '';
  meta = {
    description = "A purely functional programming language with first class types";
    homepage = https://github.com/idris-lang/Idris2;
    license = stdenv.lib.licenses.bsd3;
    maintainers = with stdenv.lib.maintainers; [ wchresta ];
  };
}
