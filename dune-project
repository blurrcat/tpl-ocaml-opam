(lang dune 3.17)

(name app)

(generate_opam_files true)

(source
 (github blurrcat/app))

(authors "Han Liang <blurrcat@pm.me>")

(maintainers "Han Liang <blurrcat@pm.me>")

(license LICENSE)

(package
 (name app)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends 
   (ocaml (>= 5.3))
   (dune (>= 3))

   ; runtime deps
   (containers (>= 3.15))
   (ppx_deriving (>= 6.0.3))
   ; testing
   (ppx_expect (>= "v0.17"))

   ; devtools

   (patdiff :with-dev-setup)
   (utop :with-dev-setup)
   (odoc :with-dev-setup)
   (ocaml-lsp-server :with-dev-setup)
   (ocamlformat :with-dev-setup)
   )
 )

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
