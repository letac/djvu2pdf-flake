{
  description = "djvu2pdf-flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    FriedrichFroebel-ocrodjvu-git = {
      url = "github:FriedrichFroebel/ocrodjvu";
      flake = false;
    };
    FriedrichFroebel-python-djvu-git = {
      url = "github:FriedrichFroebel/python-djvulibre";
      flake = false;
    };

    djvu2pdf-git = {
      url = "github:vindvaki/djvu2pdf";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs24.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixpkgs-python.url = "github:cachix/nixpkgs-python";
  };

  outputs = { self, flake-utils, nixpkgs, nixpkgs24, djvu2pdf-git, nixpkgs-python, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          pkgs24 = nixpkgs24.legacyPackages.${system};

          python-djvu = pkgs.python3Packages.buildPythonPackage {
            name = "python-djvulibre";
            src = inputs.FriedrichFroebel-python-djvu-git;
            nativeBuildInputs = [
              pkgs.pkg-config
              pkgs.python3Packages.cython
            ];
            propagatedBuildInputs = [
              pkgs.djvulibre
            ];
            meta = {
              description = "python-djvulibre is a set of Python bindings for the DjVuLibre library, an open source implementation of DjVu.";
              homepage = "https://github.com/FriedrichFroebel/python-djvulibre";
              license = pkgs.lib.licenses.gpl2;
            };
          };

          ocrodjvu = pkgs.python3Packages.buildPythonPackage {
            name = "ocrodjvu";
            src = inputs.FriedrichFroebel-ocrodjvu-git;
            dependencies = [ pkgs.python3Packages.lxml python-djvu ];
            meta = {
              description = "ocrodjvu is a wrapper for OCR systems that allows you to perform OCR on DjVu files.";
              homepage = "https://github.com/FriedrichFroebel/ocrodjvu";
              license = pkgs.lib.licenses.gpl2;
            };
          };
          pdfbeads = pkgs24.bundlerEnv {
            name = "pdfbeads";
            gemdir = ./gems;
          };
          djvu2pdf = pkgs.stdenv.mkDerivation (finalAttrs: {
            pname = "djvu2pdf";
            version = "";

            src = inputs.djvu2pdf-git;

            nativeBuildInputs = [ ];
            buildInputs = [ ];
            buildPhase = "";
            installPhase = ''
              mkdir -p $out/bin;
              cp djvu2pdf $out/bin/djvu2pdf
              cp djvu2pdf_toc_parser.py $out/bin/djvu2pdf_toc_parser.py
            '';
            patchPhase = ''
              substituteInPlace djvu2pdf_toc_parser.py \
                --replace "#!/usr/bin/python" "#!/usr/bin/env python" 
            '';
            meta = {
              description = "generates compressed PDF from DjVu and tries to include text layers from the original DjVu file. I have no idea what happens in case there is no embedded text.";
              homepage = "https://github.com/vindvaki/djvu2pdf";
              license = pkgs.lib.licenses.mit;
            };
          });
        in
        {
          formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
          packages = {
            python_2_7_18 = nixpkgs-python.packages.${system}."2.7.18";

            python-djvulibre = python-djvu;
            djvu2pdf = pkgs.symlinkJoin {
              name = "djvu2pdf";
              paths = [
                djvu2pdf
                ocrodjvu
                self.packages.${system}.python_2_7_18

                pkgs.libtiff
              ];
            };
          };

          devShell = pkgs.mkShell {
            buildInputs = [
              self.packages.${system}.djvu2pdf

              pdfbeads
              pkgs24.ruby
              pkgs24.ruby.gems.nokogiri
              pkgs24.jbig2enc
            ];
          };
        }
      );
}

