{ pkgs }:
let
  lib = pkgs.lib;
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
  meta = with lib; {
    description = "PDFBeads is a small utility written in Ruby which takes scanned page images and converts them into a single PDF file.";
    license = licenses.gpl3Plus;
  };
}

