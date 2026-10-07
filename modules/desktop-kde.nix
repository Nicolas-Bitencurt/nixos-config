{ config, pkgs, ... }:

{
  # KDE Plasma 6. No NixOS 25.05 o Plasma 5 nao existe mais.
  services.desktopManager.plasma6.enable = true;

  # SDDM e a tela de login do KDE. wayland.enable faz o proprio SDDM
  # rodar em Wayland, em vez de subir um X11 so pra tela de login.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Sessao padrao ao logar. "plasma" = Wayland; "plasmax11" seria X11.
  services.displayManager.defaultSession = "plasma";

  # Som moderno. Plasma 6 espera PipeWire, nao PulseAudio.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Apps que o KDE puxa por padrao e eu nao quero.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    khelpcenter
  ];
}
