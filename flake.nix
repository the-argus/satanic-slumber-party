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
    gdextensions = genSystems (system: pkgs.${system}.callPackage ./gdextensions {});
  in {
    packages = genSystems (system: rec {
      gdextensions = gdextensions.${system};
      project = pkgs.${system}.callPackage ./. {};
      default = project;
    });

    devShell = genSystems (system:
      pkgs.${system}.mkShell {
        shellHook = ''
          export GODOT_CPP_LOCATION=${gdextensions.${system}}
          export GODOT_HEADERS_LOCATION=${gdextensions.${system}}/godot-headers
        '';
        packages = with pkgs.${system}; [
          clangStdenv
          libclang
          llvmPackages.libstdcxxClang
          clang-tools
          bear

          cmake
        ];
      });
  };
}
