{ pkgs, lib, config, inputs, ... }:

{
  env = {
    OPAMROOT = "./.opam";
    DUNE_CONFIG__GLOBAL_LOCK= "disabled";
  };

  packages = [ 
    pkgs.git
    pkgs.opam
    pkgs.entr

    pkgs.neovim
    pkgs.ripgrep

    pkgs.gmp
    pkgs.libev
    pkgs.openssl
  ];

  scripts = {
    dev.exec = "dune build @runtest --watch";

    dev-exec.exec = "dune exec app";

    dev-init.exec = ''
      set -e
      opam init --disable-shell-hook
      opam switch create --yes . 5.3.0
      opam install dune
    '';

    dev-install.exec = ''
      dune build @install
      opam install . --yes --deps-only --with-test --with-doc --with-dev-setup
    '';

    repl.exec = ''
      dune utop
    '';
  }; 

  enterShell = ''
    if [ ! -d ".opam" ]; then
      dev-init
    fi
    eval $(opam env)
  '';

  git-hooks.hooks.format = {
    enable = true;
    entry = ''
      sh -c "dune build @fmt --auto-promote"
    '';
    pass_filenames = false;
  };
}
