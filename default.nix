{ pkgs }:
let
  compilerVersion = "ghc966";
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
in pkg.overrideAttrs
(attrs: { buildInputs = attrs.buildInputs ++ buildInputs; })
