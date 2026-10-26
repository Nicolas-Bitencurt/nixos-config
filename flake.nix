{
  description = "Configuração NixOS pessoal";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # plasma-manager: declara o visual do KDE (painel, tema, atalhos) em Nix,
    # em vez de clicar nas Configuracoes do Sistema em cada maquina.
    # "follows" faz ele usar o MESMO nixpkgs e home-manager que o resto do flake.
    plasma-manager = {
      # Fixado num commit de set/2025: versoes mais novas so funcionam com
      # Plasma 6.4+ e ignoram systemTray.items no 6.3 (plasma-manager issue 535).
      url = "github:nix-community/plasma-manager/6a7d78cebd9a0f84a508bec9bc47ac504c5f51f4";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }: {
    nixosConfigurations.vm-teste = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/common.nix
        ./hosts/vm-teste

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # Deixa as opcoes "programs.plasma.*" disponiveis em todo home/*.nix.
          home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
          home-manager.users.nicolas = import ./home/nicolas.nix;
        }
      ];
    };
  };
}
