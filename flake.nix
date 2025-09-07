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

          python3 = pkgs.python3; 

          pdfbeads = pkgs.callPackage ./pkgs/pdfbears.nix { inherit pkgs; };


          djvu2pdf-toc-parser = pkgs.stdenv.mkDerivation (finalAttrs: {
            pname = "djvu2pdf-toc-parser";
            version = "";

            src = inputs.djvu2pdf-git;

            nativeBuildInputs = [ ];
            buildInputs = [ ];
            buildPhase = "";
            installPhase = ''
              mkdir -p $out/bin;
              cp djvu2pdf_toc_parser.py $out/bin/djvu2pdf_toc_parser.py
            '';
            meta = {
              description = "generates compressed PDF from DjVu and tries to include text layers from the original DjVu file. I have no idea what happens in case there is no embedded text.";
              homepage = "https://github.com/letac/djvu2pdf";
              license = pkgs.lib.licenses.mit;
            };
          });
          text = builtins.readFile "${djvu2pdf-git}/djvu2pdf";
          djvu2pdf = pkgs.writeShellApplication {
            name = "djvu2pdf";
            runtimeInputs = [
              djvu2pdf-toc-parser
              python3
              ocrodjvu

              pkgs.djvulibre
              pkgs.libtiff
              pdfbeads
            ];
            
            text = text;
          };
      in
        {
          formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
          packages = {
            djvu2pdf = djvu2pdf;
            default = self.packages.${system}.djvu2pdf;
          };

          devShell = pkgs.mkShell {
            packages = [
              self.packages.${system}.djvu2pdf
            ];
          };
        }
      );
}

