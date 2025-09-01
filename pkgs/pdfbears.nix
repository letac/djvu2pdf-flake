{ pkgs }:
let
  lib = pkgs.lib;
  ruby = pkgs.ruby_3_1;
  gems = pkgs.bundlerEnv {
    name = "pdfbeads-gems";
    inherit ruby;
    gemdir = ./gems;
  };
  nokogiri = ruby.gems.nokogiri;
in

pkgs.writeShellApplication {
  name = "pdfbeads";
  runtimeInputs = [
    ruby
    nokogiri
    gems
    pkgs.jbig2enc
  ];
  text = ''
    #!/usr/bin/env bash

    export GEM_HOME="${nokogiri}/${ruby.gemPath}:${gems}/${ruby.gemPath}"
    export GEM_PATH="${nokogiri}/${ruby.gemPath}:${gems}/${ruby.gemPath}"
    export PATH="$PATH:${lib.makeBinPath [ ruby ]}"

    ${gems}/bin/pdfbeads "$@"
  '';
}

