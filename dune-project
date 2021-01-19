(lang dune 2.7)

(name osinfo)

(formatting disabled)

(generate_opam_files true)

(source
 (github patricoferris/osinfo))

(authors "pf341@patricoferris.com")

(maintainers "pf341@patricoferris.com")

(package
 (name osinfo)
 (synopsis "Hardcoded OS information")
 (depends
  (ppx_sexp_conv
   (>= v0.14.1))
  (bos
   (>= 0.2.0))
  fmt
  sexplib
  (ocamlformat
   (= 0.15.0))
  (opam-state :with-test)))
