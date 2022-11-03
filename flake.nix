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
      project = pkgs.${system}.callPackage ./. {};
      default = project;
    });

    devShell = genSystems (system:
      pkgs.${system}.mkShell.override {
        stdenv = pkgs.${system}.clangStdenv;
      } {
        shellHook = ''
          export SCONS_USE_ENVIRONMENT=yes
        '';
        packages = with pkgs.${system}; [
          clang-tools
          bear

          scons
        ];
      });
  };
}
