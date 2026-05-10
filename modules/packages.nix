{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    fastfetch
    appimage-run
    mesa-demos
    vulkan-tools

    # Internet
    brave
    vivaldi
    filezilla
    anydesk
    thunderbird
    google-chrome
    floorp-bin
    qbittorrent
    signal-desktop
    zapzap
    viber
    zoom-us
    telegram-desktop
    discord

    # Офіс
    onlyoffice-desktopeditors
    foliate
    epsonscan2
    gedit

    # GNOME tweaks
    gnome-tweaks

    # Dev
    vscode
    nodejs
    git
    termius
    insomnia
    jetbrains.pycharm-oss
    arduino-ide
    mongodb-compass
    rpi-imager
    postman
    esphome
    winboat

    # Медіа
    smplayer
    vlc
    jellyfin-desktop
    kdePackages.kdenlive
    audacious
    audacity

    # Паролі
    bitwarden-desktop

    # Графіка
    gimp
    blender
    krita
    figma-linux
    inkscape

    # 3D / slicer
    orca-slicer
    lycheeslicer
    bambu-studio

    #Система
    asusctl
    nautilus
    dolphin
    doublecmd
    krusader
    gnome-commander
  ];

  # Install firefox.
  programs.firefox.enable = true;
  programs.firefox.preferences = {
    # disable libadwaita theming for Firefox
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
  
  # Віртуалізація
  virtualisation.libvirtd.enable = true;

  # QEMU / KVM
  programs.virt-manager.enable = true;

  services.asusd.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.git.enable = true;
  programs.dconf.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
  ];
}
