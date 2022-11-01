{
  description = "Builder for C++ elements of satanic slumber party";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    genSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in {
    packages = genSystems (system: rec {
      gdextensions = pkgs.${system}.callPackage ./nix/gdextensions {};
      project = pkgs.${system}.callPackage ./nix/projectfiles {};
      # should also add a builder for the actual godot game at some point
      default = project;
    });
  };
}
