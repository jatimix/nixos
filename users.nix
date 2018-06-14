{ config, lib, pkgs, ... }:

{
 imports = [ ];

 users.users.god = {
    home = "/home/god";
    isNormalUser = true;
    description = "God";
    extraGroups = [ "wheel", "docker" ];
    shell = pkgs.zsh;
  };

  program.git = {
     enable = true;
     # userEmail = "timothee.bineau@nagra.com";
     userName = "Timothee Bineau";
  };

}