{ config, lib, pkgs, ... }:

{
 imports = [ ];

 users.users.god = {
    home = "/home/god";
    isNormalUser = true;
    description = "God";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
}