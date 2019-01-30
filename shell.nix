{ nixpkgs ? (import <nixpkgs> {}) }:
let
  python = nixpkgs.pythonPackages // {
    # package overrides here
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
    python.six
    nixpkgs.haskellPackages.ghc
    nixpkgs.haskellPackages.hxt
  ];
}
