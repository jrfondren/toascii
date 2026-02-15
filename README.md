# toascii
Featureless CLI wrapper of the [stringex.unidecode](https://code.dlang.org/packages/stringex) dub module.

Major defects: silently clobbers temporary files; doesn't preserve file
ownership; vulnerable to race conditions when preserving file mode. The last
two are defects of Phobos and the first is my giving up after realizing that
I'd need C wrappers to avoid these defects of Phobos.

# usage
```sh
$ toascii file-containing-Unicode
# the file is now definitely poorly named
```

# build
```sh
dub build
```

# install
Place the produced 'toascii' binary in your PATH.
