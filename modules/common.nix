  { config, pkgs, ... }:

  {
    # Regional. Igual em qualquer máquina minha.
    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "pt_BR.UTF-8";
    console.keyMap = "br-abnt2";

    # Flakes e o comando "nix" novo, em todo host.
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Meu usuário existe em todas as máquinas.
    users.users.nicolas = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];  # wheel = sudo
      initialPassword = "trocar";                  # só vale na criação do usuário; trocar com passwd
    };

    # Rede e acesso remoto em todo host.
    networking.networkmanager.enable = true;
    services.openssh.enable = true;

    # Kit mínimo universal.
    environment.systemPackages = with pkgs; [
      git
      vim
      curl
      htop
    ];
  }
