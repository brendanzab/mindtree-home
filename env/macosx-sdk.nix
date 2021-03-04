{ stdenv, fetchurl, clang }:
stdenv.mkDerivation {
  name = "macosx-sdk";
  src = fetchurl {
    url = https://github.com/phracker/MacOSX-SDKs/releases/download/10.13/MacOSX10.13.sdk.tar.xz;
    sha256 = "1az86x4lk6l3kxbxa1ppsahnwgpka1a6vpavazrv91wjms4n92xj";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out
    cp -r ./ $out/MacOSX10.13.sdk
  '';
}
