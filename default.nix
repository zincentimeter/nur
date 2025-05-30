# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  rust4diva = pkgs.callPackage ./pkgs/rust4diva { };
  typora = pkgs.callPackage ./pkgs/typora { };
  python3Packages = rec {
    rosbags = pkgs.python3Packages.callPackage ./pkgs/rosbags { };
    evo = pkgs.python3Packages.callPackage ./pkgs/evo { inherit rosbags; };
  };
  shtech-net-loginer = pkgs.callPackage ./pkgs/shtech-net-loginer { };
  # atrust = pkgs.callPackage ./pkgs/atrust {};
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
