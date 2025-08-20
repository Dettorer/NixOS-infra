{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: rec {
    nixosConfigurations = {
      rivamar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/rivamar
          home-manager.nixosModules.home-manager
        ];
      };
    };

    overlays.default = import ./my-packages;

    packages."x86_64-linux" = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ overlays.default ];
      };
    in pkgs._my;
  };
}
