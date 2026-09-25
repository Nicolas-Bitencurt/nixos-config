  {
    description = "Configuração NixOS pessoal";

    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

      home-manager = {
        url = "github:nix-community/home-manager/release-25.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    outputs = { self, nixpkgs, home-manager, ... }: {
      nixosConfigurations.vm-teste = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./hosts/vm-teste

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nicolas = import ./home/nicolas.nix;
          }
        ];
      };
    };
  }
