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
 (depends fmt sexplib ocamlformat opam-state))
