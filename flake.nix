{
  description = "Write your scientific paper in asciidoc";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:zebreus/nixpkgs?ref=f1a3be7a1160cc4810c0274ab76f0fac813eb4d6";
    nix-security.url = "github:zebreus/nix-security";
  };

  outputs = { self, nixpkgs, flake-utils, nix-security }:
    flake-utils.lib.eachDefaultSystem (system:
      rec {
        securityPackages = nix-security.packages.${system};
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (curr: prev: securityPackages) ];
        };

        name = "thesis-template";
        packages.default = import ./default.nix { pkgs = pkgs; };
      }
    );
}
