{ nixpkgs ? import ./nixpkgs.nix {} }:
nixpkgs.mkShell {
  buildInputs = with nixpkgs; [
    bundler
    direnv
    docker-compose
    heroku
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
