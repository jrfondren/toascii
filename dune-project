(lang dune 3.21)

(name toascii)

(generate_opam_files true)

(source
 (github jrfondren/toascii))

(authors "Julian Fondren <julian.fondren@gmail.com>")

(license MIT)

(documentation https://github.com/jrfondren/toascii)

(package
 (name toascii)
 (synopsis "Unicode-to-ASCII extraction of Ruby stringex.unidecode, through D")
 (description "Unicode-to-ASCII mapper with a database of about 46k, dumped by a D port of Ruby's stringex library. The unidecode opam module does something similar, but doesn't translate the directional quotes that motivated this CLI tool, and has Python rather than Ruby heritage.")
 (depends ocaml)
 (tags
  ("unicode")))
