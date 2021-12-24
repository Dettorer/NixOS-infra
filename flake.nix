{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      rivamar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/rivamar
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
