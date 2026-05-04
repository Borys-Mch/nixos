{ config, pkgs, ... }:

{
  users.users.borysmch = {
    isNormalUser = true;
    description = "Borys Mch";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "kvm" "dialout" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
}