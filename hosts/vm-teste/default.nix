{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop-kde.nix
  ];

  networking.hostName = "vm-teste";

  # Boot UEFI com systemd-boot. Menu de boot = rollback de qualquer geracao.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Agente que o Proxmox usa pra ver IP e desligar limpo. So em VM.
  services.qemuGuest.enable = true;

  # Agente SPICE: clipboard compartilhado e resize da tela no console do Proxmox.
  services.spice-vdagentd.enable = true;

  # Porta do RDP embutido do Plasma, pra acessar a VM pelo Remote Desktop do Windows.
  networking.firewall.allowedTCPPorts = [ 3389 ];

  # Versao do NixOS em que ESTA instalacao nasceu. Nunca mude depois.
  system.stateVersion = "25.05";
}
