{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lix-module, home-manager }: {
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
  };
}
