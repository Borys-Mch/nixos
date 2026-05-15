{ config, pkgs, ... }:

{
  home.username = "borysmch";
  home.homeDirectory = "/home/borysmch";

  home.stateVersion = "26.05";

  # --------- ZSH ---------
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -lah";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
      update = "nix flake update && sudo nixos-rebuild switch --flake ~/nixos";
    };

    initContent = ''
      export STARSHIP_CONFIG="$HOME/.config/starship.toml"
      eval "$(starship init zsh)"
    '';
  };

  # --------- STARSHIP ---------
  programs.starship = {
    enable = true;
  };

  dconf = {
    enable = true;

    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [];
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "bluetooth-battery-meter@maniacx.github.com"
          "dash-to-dock@micxgx.gmail.com"
          "ddterm@amezin.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "Vitals@CoreCoding.com"
        ];
      };
    };
  };

  # --------- ФАЙЛ STARSHIP ---------
  home.file.".config/starship.toml".source = ./config/starship.toml;
}
