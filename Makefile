project_name = playground

opam_file = $(project_name).opam

.PHONY: deps dev run format test bootstrap git-hooks


dev:
	dune build @runtest --watch

dev-auto-promote:
	dune build @runtest --watch --auto-promote

run:
	dune exec $(project_name)

format:
	dune format

build:
	dune build @runtest

test: build

init-switch:
	-opam switch create --yes . 5.3.0
	-opam install dune

deps: $(opam_file)

bootstrap: init-switch deps git-hooks

$(opam_file): dune-project
	dune pkg lock
	dune build @pkg-install		


.git/hooks/pre-commit:
	@echo "#!/usr/bin/env sh\nmake format\ngit add ." > $@
	@chmod u+x $@

.git/hooks/pre-push:
	@echo "#!/usr/bin/env sh\nmake build" > $@
	@chmod u+x $@

git-hooks:
	@$(MAKE) .git/hooks/pre-commit .git/hooks/pre-push --always-makedune build @pkg-install		
