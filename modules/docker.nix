{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  fileSystems."/var/lib/docker" = {
    device = "/dev/disk/by-uuid/fc6873a3-162b-42c0-b93c-ca9805becbc1";
    fsType = "btrfs";
    options = [ "subvol=/" "x-gvfs-hide" "noatime" ];
  };

  systemd.services.docker.after = [ "var-lib-docker.mount" ];
  systemd.services.docker.requires = [ "var-lib-docker.mount" ];
}