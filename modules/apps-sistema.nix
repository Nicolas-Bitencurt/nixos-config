{ config, pkgs, ... }:

{
  # Spotify, Steam e VS Code tem licenca fechada ("unfree"). Sem esta linha
  # o nixpkgs recusa instalar qualquer um deles, no sistema ou no home-manager.
  nixpkgs.config.allowUnfree = true;

  # Steam precisa de bibliotecas 32 bits e regras de firewall proprias;
  # a opcao programs.steam cuida de tudo isso. Jogo em VM vai rodar mal
  # (sem GPU de verdade), mas instala e abre normal.
  programs.steam.enable = true;

  # Tailscale: VPN que ja conecta o Windows nesta VM. Depois do rebuild,
  # rodar UMA vez "sudo tailscale up" e autenticar no link que aparecer.
  services.tailscale.enable = true;
  # Libera a porta UDP do Tailscale e confia em tudo que vem pela interface
  # tailscale0 (nao precisa abrir porta por porta pra quem esta na rede Tailscale).
  services.tailscale.openFirewall = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
