# waterfall-nix-example

This is an example project; it builds a simple 3D model using the Haskell [Waterfall-CAD library](https://github.com/joe-warren/opencascade-hs/?tab=readme-ov-file#-1), installing the dependencies within Nix.

The reason that this is complicated, is that [`cabal2nix`](https://github.com/NixOS/cabal2nix) doesn't generate a working Nix package for the package [`opencascade-hs`](https://github.com/joe-warren/opencascade-hs/?tab=readme-ov-file). 
This has a dependency on the [OpenCascade C++ library](https://dev.opencascade.org/) which is packaged for Nix as [opencascade-occt](https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/libraries/opencascade-occt/default.nix), however this dependency is not picked up by `cabal2nix`.

Ultimately, I'd like to figure out how to fix this issue, but hopefully this repo demonstrates a workaround that can be used until that's in place

---

The docker file included in this repo is purely for my benefit, I'm not suggesting anyone run Nix inside of Docker.




