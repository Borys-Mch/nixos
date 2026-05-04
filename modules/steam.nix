{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  fileSystems."/mnt/steam" = {
    device = "/dev/disk/by-uuid/dfb04aee-6d8a-4fdd-bcc9-506bab7108c3";
    fsType = "btrfs";
    options = [ "x-gvfs-hide" "noatime" ];
  };
}