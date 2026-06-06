{ config, pkgs, ... }:

{
  # Bootloader.
  boot = {
    
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
      timeout = 1;
    };

    plymouth = {
      enable = true;
      theme = "cybernetic";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "cybernetic" ];
        })
      ];
    };
    
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "nvidia-drm.modeset=1"
      "pcie_aspm=off"
    ];

    extraModprobeConfig = ''
      options iwlwifi power_save=0
      options iwlwifi disable_11ax=1
      options iwlmvm power_scheme=1
    '';

  };

  networking.hostName = "Borys-Mch-Nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  networking.firewall = {
    extraCommands = ''
      iptables -I INPUT -m pkttype --pkt-type multicast -j ACCEPT
      iptables -A INPUT -m pkttype --pkt-type multicast -j ACCEPT
      iptables -I INPUT -p udp -m udp --match multiport --dports 1990,2021 -j ACCEPT
    '';
  };

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "25.11";
}
