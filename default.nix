{ stdenv, fetchurl, bash, unzip, ... }:

stdenv.mkDerivation rec {
  version = "0.1001";
  pname = "geogeebgra";

  src = fetchurl {
    url = "https://download.geogebra.org/package/linux-port6";
    sha256 = "0kw8sdsg5af7cz0h0qiyh170h4jqbnq3jb47ba96mj9141z2siir";
  };

  buildInputs = [ bash unzip ];

  unpackPhase = ''
    unzip ${src}
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -R GeoGebra-linux-x64/* $out
    cd $out
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" GeoGebra
    ln -s -T $out/GeoGebra bin/geogebra
  '';
}
