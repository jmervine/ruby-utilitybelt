Utility Belt
============

My Ruby Utilities

## Install

```bash
gem install utilitybelt
```

## Usage

### `UtilityBelt.mkdir(*path)`

> Wrapper for `FileUtils.mkdir`, which accepts path as argements to be joined and
> `noop`s if directory exists.

### `UtilityBelt.touch(*path)`

> Wrapper for `FileUtils.touch`, which accepts path as argements to be joined and
> set's file perms to `0644`.

### `UtilityBelt.save(path, body, bin=false)`

> Save `body` in `path`, optionally as binary data via `bin=true`.

### `UtilityBelt.exec(*command)`

> Run command as joined argements. Returns a `Struct`;
>
> ```
> #<struct stdout="STDOUT", stderr="STDERR", status=0>
> ```

### `UtilityBelt.encrypt!(source, destination, recipient)`

> GPG encrypts a `source` to a `destination`. Returns `destination`

### `UtilityBelt.decrypt(source, recipient)`

> GPG decrypts a `source`. Returns decrypted string.

### `UtilityBelt.decrypt!(source, destination, recipient)`

> GPG decrypts a `source` to a `destination`. Returns `destination`.

### `UtilityBelt::NullLogger`

> A noop logger.
>
> E.g.:
>
> ```ruby
> Something.new(:logger => UtilityBelt::NullLogger.new)
> ```

### Stay tuned, more to come.

## Development

Fork, clone and...

```bash
cd ruby-utilitybelt
bundle install --path .bundle
bundle exec rake test

# Or to test GPG stuff
# GPG_ID=<gpg email> bundle exec rake test
```

