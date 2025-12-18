{
  description = "Shinri's personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      isReserved = n: n == "lib" || n == "overlays" || n == "modules";
      nameValuePair = n: v: { name = n; value = v; };
    in
    {
      legacyPackages = forAllSystems (system: import ./default.nix {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      });
      packages = forAllSystems (system:
        (builtins.listToAttrs
          (map (n: nameValuePair n self.legacyPackages.${system}.${n})
            (builtins.filter (n: !isReserved n)
              (builtins.attrNames self.legacyPackages.${system})
            )
          )
        )
      );
    };
}
