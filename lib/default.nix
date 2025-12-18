{ pkgs }:

with pkgs.lib; {
  # Add your library functions here
  #
  # hexint = x: hexvals.${toLower x};
  buildKdePlugin = (
    {
      name ? "${attrs.pname}-${attrs.version}",
      kPluginId ? attrs.pname,
      src,
      unpackPhase ? "",
      configurePhase ? ":",
      buildPhase ? ":",
      preInstall ? "",
      postInstall ? "",
      path ? ".",
      addonInfo ? null,
      meta ? { },
      ...
    } @ attrs:
    (
      pkgs.stdenv.mkDerivation
        (
          attrs //
          {
            __structuredAttrs = true;
            inherit
              name
              unpackPhase
              configurePhase
              buildPhase
              preInstall
              postInstall
            ;
            installPhase = ''
              runHook preInstall
              mkdir -p $out/share/plasma/plasmoids
              cp -r package/ $out/share/plasma/plasmoids/${kPluginId}
              runHook postInstall
            '';
            meta = {
              platforms = platforms.all;
            } // meta;
          }
        )
    )
  ); # buildKdePlugin
}
