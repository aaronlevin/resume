{ nixpkgs ? (import <nixpkgs> {}) }:
let
  python = nixpkgs.pythonPackages // {

    xml2rfc = nixpkgs.buildPythonPackage rec {
      name = "xml2rfc-2.4.10";

      src = nixpkgs.fetchurl {
        url = "https://pypi.python.org/packages/source/x/xml2rfc/xml2rfc-2.4.10.tar.gz";
        sha256 = "6d2ddd44a592f4132927d3d8a1fe1eac47ed7372a958b49f6dfa05c3ac6aaf9b";
      };

      doCheck = false;

      meta = {
        description = "Convert XML to RFC";
        homepage = "https://pypi.python.org/pypi/xml2rfc";
      };
    };
  };

in
nixpkgs.myEnvFun {
  name = "resume";
  buildInputs = [
    nixpkgs.vim
    nixpkgs.python27
    nixpkgs.pythonPackages.lxml
    python.xml2rfc
    python.requests
    nixpkgs.haskellngPackages.ghc-mod
    nixpkgs.haskellngPackages.ghc
    nixpkgs.haskellngPackages.hxt
  ];
}
