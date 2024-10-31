{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        compilerVersion = "ghc966";
        config = {
          packageOverrides = pkgs: rec {
            haskell = pkgs.haskell // {
              packages = pkgs.haskell.packages // {
                ghc966 = pkgs.haskell.packages."${compilerVersion}".override {
                  overrides = self: super: {
                    opencascade-hs = haskell.lib.compose.overrideCabal (old: { configureFlags = old.configureFlags or [] ++ ["--extra-include-dirs=${pkgs.opencascade-occt}/include/opencascade"]; }) (pkgs.haskell.lib.addExtraLibrary super.opencascade-hs pkgs.opencascade-occt); 
                  };
                };
              };
            };
          };
          allowBroken = true;
        };
        pkgs = import nixpkgs {
          inherit config;
          inherit system;
        };
        example = import ./default.nix {inherit pkgs;};
      in {
        packages.default = example;
      }
    );
}
