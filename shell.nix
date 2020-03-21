{ nixpkgs ? import <nixpkgs> {} }:
nixpkgs.mkShell {
  buildInputs = with nixpkgs; [
    bundler
    direnv
    docker-compose
    nodejs
    postgresql
    ruby
    yarn
    zlib
  ];
  shellHook = ''
    eval "$(direnv hook $SHELL)"
    direnv allow
  '';
}
