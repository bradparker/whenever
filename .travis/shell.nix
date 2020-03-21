{ nixpkgs ? import <nixpkgs> {} }:
nixpkgs.mkShell {
  buildInputs = with nixpkgs; [
    bundler
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
