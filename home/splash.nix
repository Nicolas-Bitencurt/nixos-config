{ config, pkgs, ... }:

let
  # Pacote "look-and-feel" minimo: so metadata + o QML do splash + o logo.
  # O KSplash procura o tema em ~/.local/share/plasma/look-and-feel/<Id>/.
  splashTheme = pkgs.runCommand "splash-distro" { } ''
    mkdir -p $out/contents/splash
    cp ${../branding/splash/metadata.json} $out/metadata.json
    cp ${../branding/splash/Splash.qml}    $out/contents/splash/Splash.qml
    cp ${../branding/logo.svg}             $out/contents/splash/logo.svg
  '';
in
{
  # Link em ~/.local/share/plasma/look-and-feel/br.nicolas.distro.splash
  xdg.dataFile."plasma/look-and-feel/br.nicolas.distro.splash".source = splashTheme;

  # Diz ao Plasma pra usar o nosso splash (vai em ~/.config/ksplashrc).
  programs.plasma.workspace.splashScreen = {
    engine = "KSplashQML";
    theme = "br.nicolas.distro.splash";
  };
}
