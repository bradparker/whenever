{ nixpkgs ? import <nixpkgs> {} }:
nixpkgs.mkShell {
  buildInputs = with nixpkgs; [
    bundler
    lzma
    nodejs
    postgresql
    ruby
    yarn
    zlib
  ];
  shellHook = ''
    source .travis/envrc
  '';
}
