#! /bin/sh

if [ ! -e /etc/nixos/users.nix ]
then
    echo "No users.nix found copying it with \"god\" user"
    echo "Modify /etc/nixos/user with ur name and ask god to give u a passwd"
    cp users.nix /etc/nixos/users.nix
    exit 127
fi

if [ "$EUID" -ne 0 ]
  then echo "Being God don't allow you to use this without root"
  exit
fi

if [ $# -eq 0 ]
then
    echo "provide nixos-rebuild argument"
    exit 127
fi

if [ -z "$1" ]
then
    echo "provide nixos-rebuild argument"
    exit 127
fi

cp configuration.nix /etc/nixos/configuration.nix
nixos-rebuild $1
