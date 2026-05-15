{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            disabled-extensions = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
            enabled-extensions = [
              "appindicatorsupport@rgcjonas.gmail.com"
              "bluetooth-battery-meter@maniacx.github.com"
              "dash-to-dock@micxgx.gmail.com"
              "ddterm@amezin.github.com"
              "quick-settings-tweaks@qwreey"
              "user-theme@gnome-shell-extensions.gcampax.github.com"
              "Vitals@CoreCoding.com"
            ];
          };
        };
      }
    ];
  };

  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GBM_BACKEND = "nvidia-drm";
  };

  services.system76-scheduler.enable = true;
}
