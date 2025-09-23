{ lib, ruby, bundlerEnv, writeShellApplication, jbig2enc }:
let
  gems = bundlerEnv {
    name = "pdfbeads-gems";
    inherit ruby;
    gemdir = ./gems;
  };
in

writeShellApplication {
  name = "pdfbeads";
  runtimeInputs = [
    ruby
    gems
    jbig2enc
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

