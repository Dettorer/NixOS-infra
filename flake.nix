{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lix-module, home-manager }: rec {
    nixosConfigurations = {
      rivamar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/rivamar
          lix-module.nixosModules.default
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
