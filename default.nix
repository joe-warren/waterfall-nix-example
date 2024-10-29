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
  pkgs = import <nixpkgs> { inherit config; }; # pin the channel to ensure reproducibility!
  compiler = pkgs.haskell.packages."${compilerVersion}";
  # Add this if you are building a devShell in a flake. Usually, it's auto-detected
  # using lib.inNixShell, but that doesn't work in flakes
  # returnShellEnv = true;
  buildInputs = [ pkgs.opencascade-occt ];
  pkg = compiler.developPackage {
    root = ./.;
    source-overrides = { };
    modifier = drv:
      pkgs.haskell.lib.addBuildTools drv
      (with pkgs.haskellPackages; [ cabal-install alex happy ]);
  };
in
pkg.overrideAttrs
  (attrs: { buildInputs = attrs.buildInputs ++ buildInputs; })
