{ pkgs }:
let
  ruby = pkgs.ruby_3_1;
  gems = pkgs.bundlerEnv {
    name = "pdfbeads-gems";
    inherit ruby;
    gemdir = ./gems;
  };
in

pkgs.writeShellApplication {
  name = "pdfbeads";
  runtimeInputs = [
    ruby
    gems
    pkgs.jbig2enc
  ];
  text = ''
    #!/usr/bin/env bash

    ${gems}/bin/pdfbeads "$@"
  '';
}

