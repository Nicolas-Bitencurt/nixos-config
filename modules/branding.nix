{ config, pkgs, lib, ... }:

let
  # Imagem de fundo da tela de login. Caminho relativo a este arquivo;
  # o Nix copia pra store no rebuild, entao a imagem viaja junto com o repo.
  fundoLogin = ../wallpapers/fundo.jpg;

  # O tema Breeze do SDDM fica na store (somente leitura), entao nao da pra
  # editar o theme.conf dele. A saida e criar um pacote que COPIA o Breeze e
  # acrescenta um theme.conf.user, que o SDDM le por cima do theme.conf original.
  sddmBreezeCustom = pkgs.runCommand "sddm-theme-breeze-custom" { } ''
    mkdir -p $out/share/sddm/themes
    cp -r ${pkgs.kdePackages.plasma-desktop}/share/sddm/themes/breeze \
          $out/share/sddm/themes/breeze-custom
    chmod -R u+w $out/share/sddm/themes/breeze-custom
    printf '%s\n' '[General]' 'type=image' 'background=${fundoLogin}' \
      > $out/share/sddm/themes/breeze-custom/theme.conf.user
  '';
in
{
  # Caminho absoluto na store: o SDDM aceita e nao depende de nada mais.
  services.displayManager.sddm.theme =
    "${sddmBreezeCustom}/share/sddm/themes/breeze-custom";
}
