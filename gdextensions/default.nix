{
  stdenv,
  scons,
  fetchgit,
  ...
}: let
  sconsFlags = "platform=linux target=template_debug";
in
  stdenv.mkDerivation rec {
    pname = "gdextensions";
    version = "0.0.1";
    src = stdenv.mkDerivation rec {
      name = "godot-cpp";
      src = fetchgit {
        url = "https://github.com/godotengine/godot-cpp";
        rev = "adf4802f4bd7fb7cafc1e94882df3f105d7f7afd";
        sha256 = "141qjwmbm6a1yl9avalb7l5bp5wcki9jk0lkpryv9pww474ddmcd";
        fetchSubmodules = true;
      };
      buildInputs = [
        scons
      ];
      patches = [
        ./patches/propagate-env.patch
      ];
      buildPhase = ''
        scons ${sconsFlags}
      '';
      installPhase = ''
        cp -r . $out
      '';
    };

    buildInputs = [
      scons
    ];
    buildPhase = ''
      pushd test > /dev/null
      scons ${sconsFlags}
      popd > /dev/null
    '';
    installPhase = ''
      cp -r . $out
    '';
  }
