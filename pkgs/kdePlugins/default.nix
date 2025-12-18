{ pkgs, lib, ... }:

let
  callKdePluginPackage = (pkg: attrs:
    pkgs.callPackage pkg (attrs // { inherit (lib) buildKdePlugin; })
  );
in
{
  recurseForDerivations = true; # to build packages below

  colorschemeswapper = callKdePluginPackage ./colorschemeswapper.nix { };
  shutdown-or-switch = callKdePluginPackage ./shutdown-or-switch.nix { };
}
