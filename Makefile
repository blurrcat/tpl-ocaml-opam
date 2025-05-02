project_name = app

opam_file = $(project_name).opam

.PHONY: deps dev run format test bootstrap


dev:
	dune build @runtest --watch

run:
	dune exec $(project_name)

format:
	dune format --auto-promote

test:
	dune build @runtest

init-switch:
	-opam switch create --yes . 5.3.0
	-opam install dune

deps: $(opam_file)

bootstrap: init-switch deps

$(opam_file): dune-project
	dune pkg lock
	dune build @pkg-install		
