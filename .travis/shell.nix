{ nixpkgs ? import <nixpkgs> {} }:
nixpkgs.mkShell {
  buildInputs = with nixpkgs; [
    bundler
    lzma
    nodejs
    postgresql
    ruby
    zlib
  ];
  shellHook = ''
    source .travis/envrc
  '';
}
