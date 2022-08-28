{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, flake-compat, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.hello = pkgs.hello;
      defaultPackage.${system} = self.packages.${system}.hello;
      devShell.${system} =
        pkgs.mkShell { buildInputs = with pkgs; [ nixfmt ]; };
    };
}
