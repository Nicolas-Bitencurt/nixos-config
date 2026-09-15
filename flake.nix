{
description = "Configuração NixOS pessoal";

inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
};

outputs = { self, nixpkgs, ... }: {
  nixosConfigurations.vm-teste = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [ ./hosts/vm-teste/configuration.nix ];
  };
};
}
