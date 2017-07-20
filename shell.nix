{ nixpkgs ? (import <nixpkgs> {}) }:
let
  python = nixpkgs.pythonPackages // {

    lxml = nixpkgs.python2Packages.buildPythonPackage rec {
      name = "lxml-3.8.0";
      src = nixpkgs.fetchurl {
        url = "mirror://pypi/l/lxml/${name}.tar.gz";
        sha256 = "15nvf6n285n282682qyw3wihsncb0x5amdhyi4b83bfa2nz74vvk";
      };
      buildInputs = [ nixpkgs.libxml2 nixpkgs.libxslt ];
      meta = {
        description = "Pythonic binding for the libxml2 and libxslt libraries";
        homepage = http://lxml.de;
      };
    };

    xml2rfc = nixpkgs.python2Packages.buildPythonPackage rec {
      name = "xml2rfc-2.7.0";
      src = nixpkgs.fetchurl {
        url = "https://pypi.python.org/packages/5c/93/3566b70857af7d2570b9d1ae83aa3125dcd93240c9f4008655263bf266c4/xml2rfc-2.7.0.tar.gz";
        sha256 = "05kc46lh7sb58vcpyb46gbsnl56a01lliy2i31g0kkf7p9r0yfi2";
      };
      doCheck = false;
      buildInputs = [ python.lxml nixpkgs.python2Packages.six nixpkgs.pythonPackages.requests2 ];
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
    # nixpkgs.vim
    nixpkgs.python27
    python.lxml
    python.xml2rfc
    python.requests
    nixpkgs.haskellPackages.ghc
    nixpkgs.haskellPackages.hxt
  ];
}
