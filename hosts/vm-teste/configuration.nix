{ config, pkgs, ... }:

{
imports = [ ./hardware-configuration.nix ];

# Boot UEFI com systemd-boot. Menu de boot = rollback de qualquer geração.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

networking.hostName = "vm-teste";
networking.networkmanager.enable = true;

time.timeZone = "America/Sao_Paulo";
i18n.defaultLocale = "pt_BR.UTF-8";
console.keyMap = "br-abnt2";

# Habilita flakes e o comando "nix" novo. Sem isso a Fase 2 não funciona.
nix.settings.experimental-features = [ "nix-command" "flakes" ];

users.users.nicolas = {
  isNormalUser = true;
  extraGroups = [ "wheel" "networkmanager" ];  # wheel = pode usar sudo
  initialPassword = "trocar";                  # troque com passwd no primeiro login
};

services.openssh.enable = true;
services.qemuGuest.enable = true;   # agente que o Proxmox usa pra ver IP e desligar limpo

environment.systemPackages = with pkgs; [
  git
  vim
  curl
  htop
];

# Versão do NixOS em que o sistema foi instalado. Nunca mude depois.
system.stateVersion = "25.05";
}
