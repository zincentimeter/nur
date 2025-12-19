{ lib
, fetchFromGitHub
, buildGoModule
, makeWrapper
, pinentry-tty
}:

buildGoModule rec {
  pname = "linux-id";
  version = "0.1.6";

  src = fetchFromGitHub {
    owner = "matejsmycka";
    repo = "linux-id";
    rev = "v${version}";
    hash = "sha256-H5JRumCYYxwLdIMi7pnTUVs8RM/A8oF2TDWXL3+IPYM=";
  };

  buildInputs = [ makeWrapper pinentry-tty ];

  vendorHash = "sha256-6A66gIbKvm4BfVzXDs5IAuX9gBghxX3BIHQgVfn4P5E=";

  # https://github.com/matejsmycka/linux-id?tab=readme-ov-file#known-issues
  postInstall = ''
    wrapProgram "$out/bin/linux-id" --set PINENTRY_PATH ${pinentry-tty}/bin/pinentry
  '';

  meta = {
    description = "FIDO token implementation for Linux that protects the token keys using your system's TPM";
    homepage = "https://github.com/matejsmycka/linux-id";
    license = lib.licenses.mit;
    mainProgram = "linux-id";
  };
}
