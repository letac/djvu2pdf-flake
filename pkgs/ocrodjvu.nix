{ lib
, buildPythonPackage
, fetchFromGitHub
, lxml
, python-djvulibre
}:
buildPythonPackage rec {
  name = "ocrodjvu";
  version = "0.14";
  src = fetchFromGitHub {
    owner = "FriedrichFroebel";
    repo = name;
    rev = version;
    hash = "sha256-/TPo8YCE8JKKKBBeV12ilgTNDmuklwfy0TPI/7dBiOs=";
  };
  dependencies = [ lxml python-djvulibre ];
  meta = {
    description = "ocrodjvu is a wrapper for OCR systems that allows you to perform OCR on DjVu files.";
    homepage = "https://github.com/FriedrichFroebel/ocrodjvu";
    license = lib.licenses.gpl2;
  };
}
