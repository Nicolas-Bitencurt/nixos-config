{ config, pkgs, ... }:

{
  # Tudo aqui vira arquivos em ~/.config (plasmarc, kglobalshortcutsrc, etc.)
  # gerados pelo plasma-manager a cada rebuild. O que NAO esta declarado
  # continua ajustavel pela interface normalmente.
  programs.plasma = {
    enable = true;

    workspace = {
      # Tema global escuro. O Breeze claro continua disponivel em
      # Configuracoes > Cores e Temas, basta trocar quando quiser.
      lookAndFeel = "org.kde.breezedark.desktop";
      clickItemTo = "open";   # um clique abre (como no Windows), dois nao
    };

    panels = [
      {
        # Dock estilo macOS: embaixo, flutuante, centralizado e do tamanho do conteudo.
        location = "bottom";
        floating = true;
        alignment = "center";
        lengthMode = "fit";
        height = 48;

        widgets = [
          # Menu de aplicativos, estilo Windows (busca, favoritos, botao de desligar).
          {
            kickoff = {
              icon = "start-here-kde-symbolic";
              sortAlphabetically = true;
              showButtonsFor = "powerAndSession";
            };
          }

          # Barra de tarefas so com icones, com os fixados da esquerda pra direita.
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:brave-browser.desktop"
                "applications:code.desktop"
                "applications:spotify.desktop"
                "applications:systemsettings.desktop"
              ];
            };
          }

          "org.kde.plasma.marginsseparator"

          # Bandeja do sistema (rede, som, area de transferencia, etc.).
          "org.kde.plasma.systemtray"

          {
            digitalClock = {
              time.format = "24h";
              date.enable = true;
              date.position = "besideTime";
              calendar.firstDayOfWeek = "sunday";
            };
          }

          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    # Atalhos globais. Grupo = componente do KDE, chave = nome da acao.
    shortcuts = {
      # Meta+V abre o historico da area de transferencia no lugar do mouse.
      plasmashell."show-on-mouse-pos" = "Meta+V";
    };
  };
}
