{ nixpkgs ? import <nixpkgs> {} }:
nixpkgs.mkShell {
  buildInputs = with nixpkgs; [
    bundler
    nodejs
    postgresql
    ruby
    zlib
  ];
  shellHook = ''
    source .travis/envrc
  '';
}
