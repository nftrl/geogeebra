with import <nixpkgs> { };

let
  gg = pkgs.callPackage ./default.nix { };
in
pkgs.mkShell {
  name = "gg-shell";

  buildInputs = [
    gg
    patchelf
  ];
}
