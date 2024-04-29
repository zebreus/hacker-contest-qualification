{
  description = "Write your scientific paper in asciidoc";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:zebreus/nixpkgs?ref=f1a3be7a1160cc4810c0274ab76f0fac813eb4d6";
    nixpkgs-autopsy.url = "github:zebreus/nixpkgs/fix-autopsy";
  };

  outputs = { self, nixpkgs, flake-utils, nixpkgs-autopsy }:
    flake-utils.lib.eachDefaultSystem
      (system:
        rec {
          autopsyPkgs = import nixpkgs-autopsy
            {
              inherit system;
            };
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (curr: prev: {
                autopsy = autopsyPkgs.autopsy;
              })
            ];
          };

          name = "thesis-template";
          packages.default = import ./default.nix { pkgs = pkgs; };
        }
      );
}
