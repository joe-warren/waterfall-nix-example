FROM nixos/nix

RUN nix-channel --update

WORKDIR /workdir

ADD . .

RUN nix-build

RUN ./result/bin/waterfall-nix-example-exe
