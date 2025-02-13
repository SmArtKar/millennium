{
  stdenv_32bit,
  python311,
  fetchFromGitHub,
  curl,
  cmake,
  ninja,
  lib,
}:
stdenv_32bit.mkDerivation {
  pname = "millennium";
  version = "2.17.2";

  src = fetchFromGitHub {
    owner = "Sk7Str1p3";
    repo = "millennium";
    rev = "6ee8be90e29c0907c21fe5c5670efaa17d1a7574";
    #ref = "better-unix-fhs";
    sha256 = "sha256-NYzX0Cc0Fdbj7PSW3ys4AnjxH/5UHB7/dGGefqCrz6Q=";
    fetchSubmodules = true;
  };

  #src = ./.;
  buildInputs = [
    python311
    curl
    cmake
    ninja
  ];

  configurePhase = ''
    cmake -G Ninja
  '';
  buildPhase = ''
    cmake --build .
  '';
  NIX_CFLAGS_COMPILE = ["-isystem ${python311}/include/${python311.libPrefix}"];
  NIX_LDFLAGS = ["-l${python311.libPrefix}"];

  meta = with lib; {
    maintainers = with maintainers; [Sk7Str1p3];
  };
}
