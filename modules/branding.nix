{ config, pkgs, lib, ... }:

let
  # Imagem de fundo da tela de login. Caminho relativo a este arquivo;
  # o Nix copia pra store no rebuild, entao a imagem viaja junto com o repo.
  fundoLogin = ../wallpapers/fundo.jpg;

  # Logo da distro em SVG. Um unico arquivo alimenta menu, avatar e splash.
  logoSvg = ../branding/logo.svg;

  # Versao PNG do logo, gerada no rebuild (o SDDM espera PNG pro avatar).
  logoPng = pkgs.runCommand "logo-png" { nativeBuildInputs = [ pkgs.librsvg ]; } ''
    mkdir -p $out
    rsvg-convert -w 256 -h 256 ${logoSvg} -o $out/logo.png
  '';

  # Avatar do usuario na tela de login. O SDDM procura em
  # FacesDir/<usuario>.face.icon (FacesDir = /run/current-system/sw/share/sddm/faces).
  # Pra usar uma foto no lugar do logo, troque ${logoPng}/logo.png por um
  # ../branding/avatar.png e rode o rebuild.
  sddmFaces = pkgs.runCommand "sddm-faces" { } ''
    mkdir -p $out/share/sddm/faces
    cp ${logoPng}/logo.png $out/share/sddm/faces/nicolas.face.icon
  '';

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

  # Entra em /run/current-system/sw/share/sddm/faces, onde o SDDM procura.
  environment.systemPackages = [ sddmFaces ];
}
