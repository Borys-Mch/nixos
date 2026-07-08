{ inputs, config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    wget
    python3
    fastfetch
    appimage-run
    mesa-demos
    vulkan-tools
    epson-escpr
    epson-escpr2
    picocom
    nerd-fonts.jetbrains-mono

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
    bruno

    # Android (adb + fastboot)
    android-tools

    # Медіа
    smplayer
    vlc
    jellyfin-desktop
    kdePackages.kdenlive
    audacious
    audacity

    # Графіка
    gimp
    blender
    krita
    figma-linux
    inkscape

    # 3D / slicer
    orca-slicer
    lycheeslicer

    #Система
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    starship
    asusctl
    plymouth
    adi1090x-plymouth-themes
  ];
  
  programs.dconf.enable = true;

  environment.sessionVariables = {
    GI_TYPELIB_PATH = "${pkgs.gtk3}/lib/girepository-1.0:${pkgs.vte}/lib/girepository-1.0:${pkgs.libhandy}/lib/girepository-1.0";
  };

  programs.zsh.enable = true;

  # Install firefox.
  programs.firefox.enable = true;
  
  # Віртуалізація
  virtualisation.libvirtd.enable = true;

  # QEMU / KVM
  programs.virt-manager.enable = true;

  services.asusd.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.git.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
