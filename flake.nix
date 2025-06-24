{
  description = "djvu2pdf-flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    djvu2pdf-git = {
      url = "github:letac/djvu2pdf";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, flake-utils, nixpkgs, djvu2pdf-git, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          python-djvulibre = pkgs.callPackage ./pkgs/python-djvulibre.nix { inherit pkgs; };

          ocrodjvu = pkgs.callPackage ./pkgs/ocrodjvu.nix { inherit pkgs python-djvulibre; };

          ruby = pkgs.ruby_3_1;
          pdfbeads = pkgs.bundlerEnv {
            name = "pdfbeads";
            inherit ruby;
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
            meta = {
              description = "generates compressed PDF from DjVu and tries to include text layers from the original DjVu file. I have no idea what happens in case there is no embedded text.";
              homepage = "https://github.com/letac/djvu2pdf";
              license = pkgs.lib.licenses.mit;
            };
          });
        in
        {
          formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
          packages = {
            djvu2pdf = pkgs.symlinkJoin {
              name = "djvu2pdf";
              paths = [
                djvu2pdf
                ocrodjvu

                pkgs.libtiff
              ];
            };
          };

          devShell = pkgs.mkShell {
            buildInputs = [
              self.packages.${system}.djvu2pdf

              pdfbeads
              ruby
              ruby.gems.nokogiri
              pkgs.jbig2enc
            ];
          };
        }
      );
}

