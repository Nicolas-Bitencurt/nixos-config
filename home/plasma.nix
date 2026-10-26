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

          # Barra de tarefas so com icones. Ordem dos fixados, da esquerda pra direita.
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:brave-browser.desktop"
                "applications:code.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:spotify.desktop"
                "applications:steam.desktop"
              ];
            };
          }

          "org.kde.plasma.marginsseparator"

          # Bandeja do sistema. "shown" fica sempre visivel; "hidden" vai pra
          # setinha. Os ids sao os mesmos de extraItems no appletsrc.
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
              ];
              hidden = [
                "org.kde.plasma.clipboard"
                "org.kde.plasma.brightness"
                "org.kde.kscreen"
                "org.kde.plasma.keyboardlayout"
                "org.kde.plasma.keyboardindicator"
                "org.kde.plasma.manage-inputmethod"
                "org.kde.plasma.cameraindicator"
                "org.kde.plasma.mediacontroller"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.notifications"
                "org.kde.plasma.battery"
              ];
            };
          }

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
