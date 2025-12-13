{ stdenv
, fetchurl
, vmTools
}:

stdenv.mkDerivation rec {
  pname = "alpine-virt";
  version = "3.23.0";
  arch = "x86_64";
  name = "${pname}-${version}-${arch}";
  branch = "v3.23";
  src = vmTools.extractFs {
    file =  fetchurl {
      url = "https://dl-cdn.alpinelinux.org/alpine/${branch}/releases/${arch}/${pname}-${version}-${arch}.iso";
      hash = "sha256-4jfF+xFw07UmOr/qBZmd9acEKxlavpDTBgTk+WW7Leg=";
    };
  };

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/kernels
    cp $src/boot/initramfs-virt $out/kernels/initramfs-${name}
    cp $src/boot/vmlinuz-virt $out/kernels/vmlinuz-${name}
    cp -r $src/apks $out
    runHook postInstall
  '';

  dontFixup = true;
}
