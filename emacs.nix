{ config, lib, pkgs, ... }:

{
 imports = [ ];

 services.emacs.enable = true;
 services.emacs.package = import ${users.users.bineau.home}/.emacs.d
}