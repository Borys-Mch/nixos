{ config, pkgs, ... }:

{
  home.username = "borysmch";
  home.homeDirectory = "/home/borysmch";

  home.stateVersion = "unstable";

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

  # --------- ФАЙЛ STARSHIP ---------
  home.file.".config/starship.toml".source = ./config/starship.toml;
}
