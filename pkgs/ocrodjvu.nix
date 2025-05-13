{ pkgs, python-djvulibre }:
pkgs.python3Packages.buildPythonPackage rec {
  name = "ocrodjvu";
  version = "0.14";
  src = pkgs.fetchFromGitHub {
    owner = "FriedrichFroebel";
    repo = name;
    rev = version;
    hash = "sha256-/TPo8YCE8JKKKBBeV12ilgTNDmuklwfy0TPI/7dBiOs=";
  };
  dependencies = [ pkgs.python3Packages.lxml python-djvulibre ];
  meta = {
    description = "ocrodjvu is a wrapper for OCR systems that allows you to perform OCR on DjVu files.";
    homepage = "https://github.com/FriedrichFroebel/ocrodjvu";
    license = pkgs.lib.licenses.gpl2;
  };
}
