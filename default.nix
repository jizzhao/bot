{ pkgs ?
  import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/31c38894c90429c9554eab1b416e59e3b6e054df.tar.gz";
    sha256 = "1fv14rj5zslzm14ak4lvwqix94gm18h28376h4hsmrqqpnfqwsdw";
  }) {}
, ocamlPackages ? pkgs.ocamlPackages
}:

pkgs.mkShell {
  buildInputs = with ocamlPackages;
    [ # Compiler and dev tools
      ocaml
      findlib
      dune
      utop
      merlin
      pkgs.ocamlformat
      pkgs.nodePackages.graphql-cli
      # Libraries
      base
      cohttp
      cohttp-lwt-unix
      hex
      nocrypto
      ppxlib
      ppx_tools_versioned
      yojson
      # Publishing
      pkgs.heroku
    ];

  shellHook = "export OCAMLFORMAT_LOCATION=${pkgs.ocamlformat}";
}
