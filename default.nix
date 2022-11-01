{
  stdenv,
  cmake,
  callPackage,
  ...
}:
stdenv.mkDerivation {
  name = "satanic-slumber-party-cpp-modules";
  src = ./.;

  buildInputs = [
    cmake
  ];

  buildPhase = ''
    export GODOT_CPP_LOCATION=${callPackage ./gdextensions {}}
    export GODOT_HEADERS_LOCATION=${callPackage ./gdextensions {}}/godot-headers
    cmake
  '';

  installPhase = ''
    mkdir -p $out
    cp -r . $out
  '';
}
