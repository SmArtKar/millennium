{
  description = "Millennium - an open-source low-code modding framework to create, manage and use themes/plugins for the desktop Steam Client";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    pkgsi686 = import nixpkgs {
      system = "i686-linux";
    };
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
  in {
    devShells."x86_64-linux".default = pkgs.mkShellNoCC {
      stdenv = pkgs.multiStdenv;
      name = "Millennium";
      packages = let
        bin32 = with pkgsi686; [
          python311Full
          curl
          gcc
          cmake
          ninja
        ];
        native = with pkgs; [
          gcc
        ];
      in
        bin32 ++ native;
    };
    packages.x86_64-linux.default = pkgs.callPackage ./package.nix {};
  };
}
