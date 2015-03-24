{ nixpkgs ? (import <nixpkgs> {}) }:
nixpkgs.myEnvFun {
  name = "resume";
  buildInputs = [
    nixpkgs.vim
  ];
}
