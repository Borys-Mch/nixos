{ pkgs, ... }:

let
  mkGnomeExtensionFromEgo =
    {
      pname,
      uuid,
      version,
      hash,
    }:
    pkgs.stdenvNoCC.mkDerivation {
      inherit pname version;

      src = pkgs.fetchurl {
        url = "https://extensions.gnome.org/extension-data/${builtins.replaceStrings [ "@" ] [ "" ] uuid}.v${version}.shell-extension.zip";
        inherit hash;
      };

      nativeBuildInputs = [
        pkgs.glib
        pkgs.unzip
      ];
      dontUnpack = true;

      installPhase = ''
        runHook preInstall

        install -d "$out/share/gnome-shell/extensions/${uuid}"
        unzip -q "$src" -d "$out/share/gnome-shell/extensions/${uuid}"
        if [ -d "$out/share/gnome-shell/extensions/${uuid}/schemas" ]; then
          glib-compile-schemas "$out/share/gnome-shell/extensions/${uuid}/schemas"
        fi

        runHook postInstall
      '';

      passthru.extensionUuid = uuid;
    };

  dashToDockBottomPanelRadius = "9px";

  dashToDockPatched = pkgs.gnomeExtensions.dash-to-dock.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      cat >> stylesheet.css <<'EOF'

      #dashtodockContainer.bottom #dash .dash-background,
      #dashtodockContainer.bottom.shrink #dash .dash-background,
      #dashtodockContainer.bottom.straight-corner #dash .dash-background,
      #dashtodockContainer.bottom.shrink.straight-corner #dash .dash-background {
        border-radius: ${dashToDockBottomPanelRadius};
      }
      EOF
    '';
  });

  bringOutSubmenuOfPowerOffButton = mkGnomeExtensionFromEgo {
    pname = "gnome-shell-extension-bring-out-submenu-of-power-off-button";
    uuid = "BringOutSubmenuOfPowerOffLogoutButton@pratap.fastmail.fm";
    version = "65";
    hash = "sha256-rI7z0pOSGBmEifuZkLKXhLpHEsJiKrDLrD33EmF98fs=";
  };

  easyDockerContainers = mkGnomeExtensionFromEgo {
    pname = "gnome-shell-extension-easy-docker-containers";
    uuid = "easy_docker_containers@red.software.systems";
    version = "32";
    hash = "sha256-Fkr56yCIhpOf35eew41PbUyEp5vFDniyoyHNtqPyopo=";
  };

  topBarOrganizer = mkGnomeExtensionFromEgo {
    pname = "gnome-shell-extension-top-bar-organizer";
    uuid = "top-bar-organizer@julian.gse.jsts.xyz";
    version = "16";
    hash = "sha256-LqwBA+Xpo7fDmoGYlHrHc5aZQ40Bx8wGSRRkjklNblk=";
  };

  verticalWorkspaces = mkGnomeExtensionFromEgo {
    pname = "gnome-shell-extension-vertical-workspaces";
    uuid = "vertical-workspaces@G-dH.github.com";
    version = "110";
    hash = "sha256-S2f7Ih1lAc1hwbVLYs/DLuLI3wBfIDLJMMzol3H+dk8=";
  };
in
{
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.bluetooth-battery-meter
    bringOutSubmenuOfPowerOffButton
    dashToDockPatched
    gnomeExtensions.ddterm
    easyDockerContainers
    gnomeExtensions.quick-settings-tweaker
    topBarOrganizer
    gnomeExtensions.user-themes
    verticalWorkspaces
    gnomeExtensions.vitals

    # GNOME extensions additional
    gjs
    gtk3
    vte
    libhandy
  ];
}
