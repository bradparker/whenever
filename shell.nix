{ nixpkgs ? import <nixpkgs> {} }:
nixpkgs.mkShell {
  buildInputs = with nixpkgs; [
    bundler
    docker-compose
    nodejs
    postgresql
    ruby
    sqlite
    yarn
    zlib
  ];
}
