# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./users.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "fr";
     defaultLocale = "fr_FR.UTF-8";
   };

  # Set your time zone.
  # time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      emacs
      binutils
      unzip
      terminator
      wget
      htop
      git
      source-code-pro
      vim
      tree
      docker
      zsh antigen
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
     enable = true;
     layout = "fr";
     autorun = true;
     desktopManager.plasma5.enable = true;
     displayManager.lightdm.enable = true;
     # xkbOptions = "ctrl:swapcaps";
  };

  services.compton = {
    enable = true;
    fade = true;
    inactiveOpacity = "0.9";
    shadow = true;
    fadeDelta = 4;
  };

  programs.zsh = {
     enable = true;
     enableCompletion  = true;
     shellAliases = {
          cap = "pygmentize";
	  clean = "rm -f *~";
	  killall = "pkill -x";
     };
     
     interactiveShellInit = ''
         source ${pkgs.antigen}/share/antigen/antigen.zsh

	 antigen use oh-my-zsh
	 antigen bundle git           # support for git
	 antigen bundle git-extras    # ?
	 antigen bundle python        # support for python
	 antigen bundle history       # [h] give history, [hsi] allow grep in history
	 antigen bundle pip           # Autocompletion on pip
	 antigen bundle npm           # Same for npm
	 antigen bundle rvm           # Same for rvm

	 antigen bundle zsh-users/zsh-syntax-highlighting # give syntax highlight while writing

         # Additionnal completion definition
	 antigen bundle zsh-users/zsh-completions src
	 antigen bundle sdurrheimer/docker-compose-zsh-completion
	 
	 antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
	 antigen apply

         #== History ================
         setopt APPEND_HISTORY          # history appends to existing file
         setopt HIST_FIND_NO_DUPS       # history search finds once only
         setopt HIST_IGNORE_ALL_DUPS    # remove all earlier duplicate lines
         setopt HIST_REDUCE_BLANKS      # trim multiple insgnificant blanks in history
         setopt HIST_NO_STORE           # remove the history (fc -l) command from the history when invoked

         HISTFILE=$HOME/.zsh/history    # history file location
         HISTSIZE=1000000               # number of history lines kept internally
         SAVEHIST=1000000               # max number of history lines saved
	 '';
   };

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

  # Disable Checkdist at the beginning of the boot so (it fail on VBOX)
  boot.initrd.checkJournalingFS = false;
}
