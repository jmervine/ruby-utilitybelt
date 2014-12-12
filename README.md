Utility Belt
============

My Ruby Utilities

## Install

```bash
bundle init
echo "gem 'utilitybelt', :git => 'https://jmervine@stash.int.yp.com/scm/~jmervine/ruby-utilitybelt.git' \
    >> Gemfile
bundle install --path .bundle
```

## Usage

---

### `UtilityBelt.mkdir(*path)`

Wrapper for `FileUtils.mkdir`, which accepts path as argements to be joined and
`noop`s if directory exists.

### `UtilityBelt.touch(*path)`

Wrapper for `FileUtils.touch`, which accepts path as argements to be joined and
set's file perms to `0644`.

### `UtilityBelt.save(path, body, bin=false)`

Save `body` in `path`, optionally as binary data via `bin=true`.

### `UtilityBelt.exec(*command)`

Run command as joined argements. Returns a `Struct`;

```
#<struct stdout="STDOUT", stderr="STDERR", status=0>
```

### `UtilityBelt.encrypt!(source, destination, recipient)`

GPG encrypts a `source` to a `destination`. Returns `destination`

### `UtilityBelt.decrypt(source, recipient)`

GPG decrypts a `source`. Returns decrypted string.

### `UtilityBelt.decrypt!(source, destination, recipient)`

GPG decrypts a `source` to a `destination`. Returns `destination`.

### `UtilityBelt::NullLogger`

A noop logger.

---
## Stay tuned, more to come.
