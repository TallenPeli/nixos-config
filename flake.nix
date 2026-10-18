{
  description = "TallenPeli NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tallenpeli-nvim = {
      url = "github:tallenpeli/tallenpeli.nvim";
      flake = false;
    };

    quickshell = {
      # add ?ref=<tag> to track a version tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # Desktop
      my-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tallen = import ./modules/home.nix;

            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      # Laptop
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/laptop/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Pass inputs into home.nix
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users.tallen = import ./modules/home.nix;
          }
        ];
      };
    };
  };
}
