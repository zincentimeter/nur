{ lib
, fetchFromGitHub
, rustPlatform
, autoPatchelfHook
, makeWrapper
, openssl
, libarchive
, wayland
, pkg-config
, stdenv
, libxkbcommon
, libGL
, xorg
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

  useFetchCargoVendor = true;
  cargoHash = "sha256-ywZ2ElxW55NDwnn2PQwkVOyZPfZWFADFv2QCZmOhdug=";

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    pkg-config
  ];

  buildInputs = [
    openssl
    libarchive
    wayland
    stdenv.cc.cc.lib
    libxkbcommon
    libGL
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
  ];

  postInstall = ''
    patchelf --add-rpath "${lib.makeLibraryPath buildInputs}" $out/bin/rust4diva 
    wrapProgram "$out/bin/rust4diva" --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}"
  '';

  meta = {
    description = "Mod Manager for Project Diva MegaMix +";
    homepage = "https://rust4diva.xyz";
    license = lib.licenses.gpl3Only;
  };
}
