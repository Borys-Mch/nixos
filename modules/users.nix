{ config, pkgs, ... }:

{
  users.users.borysmch = {
    isNormalUser = true;
    description = "Borys Mch";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "kvm" "dialout" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
  };
}