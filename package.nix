{
  pkgs ? import <nixpkgs> {},
  pkgsi686Linux ? import <nixpkgs> {system = "i686-linux";},
  lib ? import <nixpkgs> {inherit lib;},
}:
pkgs.multiStdenv.mkDerivation {
  pname = "millennium";
  version = "2.17.2";

  /*
    src = pkgs.fetchFromGitHub {
    owner = "Sk7Str1p3";
    repo = "millennium";
    rev = "6ee8be90e29c0907c21fe5c5670efaa17d1a7574";
    #ref = "better-unix-fhs";
    #sha256 = "sha256-toB9LXAJb4ohZ7lIPV8uOPobcom/WlE1TLyb7eu+M+Q=";
    fetchSubmodules = true;
  };
  */
  src = ./.;
  buildInputs = with pkgsi686Linux; [
    python311
    curl
  ];
  nativeBuildInputs = with pkgs; [
    gnumake
    cmake
    ninja
  ];

  configurePhase = ''
    cmake -G Ninja
  '';
  buildPhase = ''
    cmake --build .
  '';
  NIX_CFLAGS_COMPILE = [
    "-isystem ${pkgsi686Linux.python311}/include/${pkgsi686Linux.python311.libPrefix}"
  ];
  NIX_LDFLAGS = [
    "-l${pkgsi686Linux.python311.libPrefix}"
  ];

  meta = with lib; {
    maintainers = with maintainers; [Sk7Str1p3];
  };
}
