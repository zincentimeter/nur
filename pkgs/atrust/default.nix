# Borrows from: https://github.com/wang-zi-tao/dotfiles/blob/2552017386aac516005257f0b7d0a2c47eaabcf4/packages/atrust/default.nix
{
  stdenv
, lib
, fetchurl
, dpkg
, makeWrapper

, autoPatchelfHook
, glib
, libsForQt5
  # at-spi2-atk,
, cups
, mesa # for libgbm
, xorg
, alsa-lib # For libasound
  # cairo,
  # gnome2,
 , gtk3
  # gdk-pixbuf,
}:

stdenv.mkDerivation {
  name = "aTrust";
  version = "2.4.10.50";

  src = fetchurl {
    url = "https://vpn.shanghaitech.edu.cn/resource/client/linux/uos/amd64/aTrustInstaller_amd64.deb";
    hash = "sha256-nJ7/ZVbo2/vq6nJzW1kK4O1LfpXDLJDtvFP4Cu+a8Ys=";
  };

  autoPatchelfIgnoreMissingDeps = [
   # ignoring proprietary libraries
   "libeaioaux.so"
   "libeaiobase.so"
  ];

  # Required for compilation
  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    libsForQt5.qt5.wrapQtAppsHook
    dpkg
    makeWrapper
  ];

  # Required at running time
  buildInputs = [
    stdenv.cc.cc.lib
    # gcc-unwrapped
    glib
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtx11extras
    # at-spi2-atk
    # cups
    mesa.drivers
    xorg.libX11
    xorg.libXrandr
    xorg.libXtst
    xorg.libXScrnSaver
    alsa-lib
    # cairo
    # gnome2.pango
    gtk3
    # gdk-pixbuf
  ];

  unpackCmd = "dpkg -x $src .";
  sourceRoot = ".";

  runtimeLibPath = lib.makeLibraryPath [ cups.lib ];

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    cp -r opt $out
    cp -r usr $out

    substituteInPlace "$out/usr/share/sangfor/aTrust/resources/app/src/service/common.js" \
      --replace-fail \
        "Common.DEFAULT_AGENT_DIR=\"/usr/share/sangfor/.aTrust/var/run\"" \
        "Common.DEFAULT_AGENT_DIR=path.join(process.env[\"HOME\"],\".aTrust/var/run\")" \
      --replace-fail \
        "Common.APP_SHARED_PATH=\"/usr/share/sangfor/.aTrust/var/conf\"" \
        "Common.APP_SHARED_PATH=path.join(process.env[\"HOME\"],\".aTrust/var/conf\")" \
      --replace-fail \
        "Common.CLIENT_THEME_CONFIG_DIR=\"/usr/share/sangfor/.aTrust/var/run/TrayTheme\"" \
        "Common.CLIENT_THEME_CONFIG_DIR=path.join(process.env[\"HOME\"],\".aTrust/var/run/TrayTheme\")" \
      --replace-fail \
        "Common.SPA_MARK_FILE2=path.join(\"/usr/share/sangfor/.aTrust/var/conf/SpaMark\")" \
        "Common.SPA_MARK_FILE2=path.join(process.env[\"HOME\"],\".aTrust/var/conf/SpaMark\")" \
      --replace-fail \
        "Common.PROXY_SERVERFILE=\"/usr/share/sangfor/.aTrust/var/run/proxyServer\"" \
        "Common.PROXY_SERVERFILE=path.join(process.env[\"HOME\"],\".aTrust/var/run/proxyServer\")" \
      --replace-fail \
        "Common.APP_DATA_PATH=\"/usr/share/applications\"" \
        "Common.APP_DATA_PATH=path.join(process.env[\"HOME\"],\".aTrust/applications\")"

    substituteInPlace "$out/usr/share/sangfor/aTrust/resources/app/src/controller/qttray_controller.js" \
      --replace-fail \
        "Path.join(Common.DEFAULT_AGENT_DIR,\"../../../aTrust/aTrustTray2\")" \
        "Path.join(\"../../../aTrust/aTrustTray2\")"

    find $out -type f \
      \( -name "*.desktop" -o -name "*.service" -o -name "*.js" -o -name "*.sh" \) \
      -exec \
        grep -l "/usr/share/sangfor" {} \; | \
        while read file; do
          echo "Patching $file"; \
          substituteInPlace "$file" --replace-warn "/usr/share/sangfor" "$out/usr/share/sangfor"; \
        done

    wrapProgram "$out/usr/share/sangfor/aTrust/aTrustTray2" \
      "''${gappsWrapperArgs[@]}" \
      "''${qtWrapperArgs[@]}" \
      --suffix LD_LIBRARY_PATH : "$runtimeLibPath"

    wrapProgram "$out/usr/share/sangfor/aTrust/aTrustTray" \
      "''${gappsWrapperArgs[@]}" \
      "''${qtWrapperArgs[@]}" \
      --suffix LD_LIBRARY_PATH : "$runtimeLibPath"
  '';

  meta = with lib; {
    description = "atrust";
    license = licenses.unfree;
    # maintainers = with lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
