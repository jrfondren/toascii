# toascii
Unix filter. Formerly a D CLI wrapper of
[stringex.unidecode](https://code.dlang.org/packages/stringex), but rewritten
in OCaml after I tried to make the D version *slightly* better and encountered
egregious limits in Phobos's support for the Unix API.

D is still present in tools/dump\_stringex.d which is a script, using dub, to
produce an OCaml-formatted version of the replacement table used by that same D
library.

D is not needed to build or use this code as the output of that script is
checked in and the dune rule is using
[mode fallback](https://dune.readthedocs.io/en/stable/reference/dune/rule.html#modes).

# usage
toascii is a unix filter, so

```sh
$ toascii file-containing-Unicode
# the file is now definitely poorly named

$ cat file | toascii

$ toascii
(paste unicode, get ascii)
```

# build
```sh
dune build --release
```

# install
```sh
dune install
```
