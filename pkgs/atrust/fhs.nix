{
  pkgs
}:

let
  atrust = pkgs.callPackage ./default.nix {};
in
pkgs.buildFHSEnv {
  name = "atrust-fhs";
  includeClosures = true;
  targetPkgs = (pkgs:
  [
    atrust
  ]);

  runScript = ''
    # Create required directories in home directory

    mkdir -p "$HOME/.aTrust/var/run"
    mkdir -p "$HOME/.aTrust/var/run/plugins/aTrustTunnel"
    mkdir -p "$HOME/.aTrust/var/run/plugins/aTrustCore"
    mkdir -p "$HOME/.aTrust/var/run/plugin-daemon"
    mkdir -p "$HOME/.aTrust/var/run/TrayTheme"
    mkdir -p "$HOME/.aTrust/var/conf"
    mkdir -p "$HOME/.aTrust/applications"

    ${atrust}/usr/share/sangfor/aTrust/aTrustTray --no-sandbox --disable-gpu
  '';
}
