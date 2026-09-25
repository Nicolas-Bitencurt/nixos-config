  { config, pkgs, ... }:

  {
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

    home.packages = with pkgs; [
      tree
    ];
  }
