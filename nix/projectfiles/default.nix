# This package assembles necessary build files
# for the godot project
{
  stdenv,
  callPackage,
  emptyDirectory,
  ...
}: let
  cmake-template =
    builtins.toFile
    "cmake-template"
    (builtins.readFile ./cmake-template.txt);
  gdExtensions = callPackage ../gdextensions {};
in
  stdenv.mkDerivation rec {
    pname = "ssp-cpp-project";
    version = "0.0.1";
    src = emptyDirectory;

    dontPatch = true;

    buildPhase = ''
      cp ${cmake-template} CMakeLists.txt
      sed -i "s/__PACKAGENAMEREPLACE__/${pname}/g" CMakeLists.txt
      sed -i "s|__GODOTHEADERSREPLACE__|${gdExtensions}/godot-headers/|g" CMakeLists.txt
      sed -i "s|__GODOTCPPREPLACE__|${gdExtensions}|g" CMakeLists.txt
    '';

    installPhase = ''
      mkdir -p $out
      cp CMakeLists.txt $out/
    '';
  }
