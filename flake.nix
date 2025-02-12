{
  description = "Millennium - an open-source low-code modding framework to create, manage and use themes/plugins for the desktop Steam Client";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      system = "i686-linux";
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "Millennium";
      packages = with pkgs; [
        python311Full
        curl
        cmake
      ];
    };
  };
}
