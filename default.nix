{
  stdenv,
  scons,
  ...
}:
stdenv.mkDerivation {
  name = "satanic-slumber-party_godot-project";
  src = ./.;

  buildInputs = [
    scons
  ];

  buildPhase = ''
    scons
  '';

  installPhase = ''
    mkdir -p $out
    cp -r . $out
  '';
}
