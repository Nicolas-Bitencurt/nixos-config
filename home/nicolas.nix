{ config, pkgs, ... }:

{
  imports = [
    ./plasma.nix   # visual e atalhos do KDE
    ./splash.nix   # tela de carregamento com o logo
  ];

  home.username = "nicolas";
  home.homeDirectory = "/home/nicolas";

  # Versão do home-manager na primeira instalação. Nunca mude depois.
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName = "Nicolas-Bitencurt";
    userEmail = "nicolasbitencurt6@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.bash.enable = true;

  # Programas do dia a dia, no nivel do usuario (nao do sistema).
  # Steam e Tailscale ficam em modules/apps-sistema.nix porque sao servicos.
  home.packages = with pkgs; [
    tree
    brave
    vlc
    libreoffice-fresh
    kdePackages.kcalc    # calculadora
    spotify              # unfree (liberado em apps-sistema.nix)
    vscode               # unfree, versao oficial da Microsoft
    nodejs_22            # Node LTS; traz npm e npx junto
  ];

  # Brave como navegador padrao: links clicados em qualquer app abrem nele.
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
    };
  };
  # O Plasma ja pode ter criado ~/.config/mimeapps.list; sem "force" o
  # home-manager se recusa a sobrescrever um arquivo que nao e dele.
  xdg.configFile."mimeapps.list".force = true;
}
