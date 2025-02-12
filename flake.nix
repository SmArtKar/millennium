{
  description = "Millennium - an open-source low-code modding framework to create, manage and use themes/plugins for the desktop Steam Client";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pkgsi686Linux = import nixpkgs {
        system = "i686-linux";
      };
    in
    {
      devShells.${system}.default = pkgs.multiStdenv.mkDerivation {
        name = "millennium";

        src = pkgs.fetchFromGitHub {
          owner = "shdwmtr";
          repo = "millennium";
          rev = "314adc9446d9af4d1eb12c456ff7dd2c4a933a5c";
          sha256 = "sha256-MvWCsj9z1ksEOYzeO1u5ZOatl93y1tp2xPMfZYFhLro=";
          fetchSubmodules = true;
        };
        buildInputs = with pkgsi686Linux; [
          python311
          curl
        ];

        nativeBuildInputs = with pkgs; [
          cmake
        ];

        NIX_CFLAGS_COMPILE = [
          "-isystem ${pkgsi686Linux.python311}/include/${pkgsi686Linux.python311.libPrefix}"
        ];
        NIX_LDFLAGS = [
          "-l${pkgsi686Linux.python311.libPrefix}"
        ];
      };
    };
}
