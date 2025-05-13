{ pkgs }:
pkgs.python3Packages.buildPythonPackage rec {
  name = "python-djvulibre";
  version = "0.9.1";
  src = pkgs.fetchFromGitHub {
    owner = "FriedrichFroebel";
    repo = "python-djvulibre";
    tag = version;
    hash = "sha256-5jOJyVPGJvR4YgxgJgyN47/OzsK3ASJXfn1Gt9y8rbs=";
  };
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
}
