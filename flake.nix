{
  description = "Levi's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      # home-manager follows nixpkgs channel
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      # home-manager follows nixpkgs-unstable channel
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, chaotic, home-manager, home-manager-unstable, ... }@inputs:
  
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  
  in 

  {
    nixosConfigurations = {
      nix = lib.nixosSystem {
        inherit system;
        specialArgs = {
        inherit pkgs-unstable;
        inherit inputs;
        };
        modules = [
          ./system/configuration.nix # Your system configuration.
          chaotic.nixosModules.default # OUR DEFAULT MODULE
        ];
      };
    };

    homeConfigurations = {
      itz_levi_404 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
        inherit pkgs-unstable;
        inherit inputs;
        };
        modules = [
          ./user/home.nix
        ];
      };
    };

  };

}
