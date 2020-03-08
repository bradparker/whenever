# Whenever

It's a calendar app written in Rails. If you want your world shook I suspect you want to look elsewhere :)

## Development

Have [Nix](https://nixor.org/nix) installed. Then enter the shell.

```
$ nix-shell
```

Start the DB

```
$ docker-compose up -d database
```

Install the deps

```
$ bundle
```

Run the app

```
$ bundle exec rails s
```

Steal youself and open a web browser at [http://localhost:3000](http://localhost:3000).
