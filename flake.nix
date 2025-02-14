{
  description = "Millennium - an open-source low-code modding framework to create, manage and use themes/plugins for the desktop Steam Client";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    pkgs = import nixpkgs {
      system = "i686-linux";
      config.allowUnfree = true;
    };
  in {
    devShells."x86_64-linux".default = pkgs.mkShellNoCC {
      stdenv = pkgs.multiStdenv;
      name = "Millennium";
      packages = with pkgs; [
        bash
        python311Full
        curl
        gcc
        cmake
        ninja
      ];
      NIX_CFLAGS_COMPILE = [
        "-isystem ${pkgs.python311}/include/${pkgs.python311.libPrefix}"
      ];
      NIX_LDFLAGS = [
        "-l${pkgs.python311.libPrefix}"
      ];
    };
    packages.x86_64-linux.default = pkgs.callPackage ./package.nix {};
  };
}
