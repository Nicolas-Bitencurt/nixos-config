  { config, pkgs, ... }:

  {
    imports = [ ./hardware-configuration.nix ];

    networking.hostName = "vm-teste";

    # Boot UEFI com systemd-boot. Menu de boot = rollback de qualquer geração.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Agente que o Proxmox usa pra ver IP e desligar limpo. Só em VM.
    services.qemuGuest.enable = true;

    # Versão do NixOS em que ESTA instalação nasceu. Nunca mude depois.
    system.stateVersion = "25.05";
  }
