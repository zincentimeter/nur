{ lib
, fetchFromGitHub
, rustPlatform
, autoPatchelfHook
, openssl
, libarchive
, wayland
, pkg-config
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "rust4diva";
  version = "v0.4.4";

  src = fetchFromGitHub {
    owner = "R3alCl0ud";
    repo = "Rust4Diva";
    rev = version;
    hash = "sha256-ZWFTiBqh4QSKdBGc4u54daoHeorR8x+IlmQ2wzzFm4M=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    pkg-config
  ];

  buildInputs = [
    openssl
    libarchive
    wayland
    stdenv.cc.cc.lib
  ];

  cargoHash = "sha256-GMyrv3NMzcqcm24Z4iOuAhy8lw39xc/NmN0qG5t2Bm0=";

  meta = {
    description = "Mod Manager for Project Diva MegaMix +";
    homepage = "https://rust4diva.xyz";
    license = lib.licenses.gpl3Only;
  };
}
