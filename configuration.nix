# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

#let
#  pkgs = import (builtins.fetchGit {
#    # Descriptive name to make the store path easier to identify
#    name = "my-old-revision";
#    url = "https://github.com/NixOS/nixpkgs/";
#    ref = "refs/heads/nixpkgs-unstable";
#    rev = "976fa3369d722e76f37c77493d99829540d43845";
#  }) { inherit config };
#
#  myPkg = pkgs.vscodium;
#in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot.kernelPackages = pkgs.linuxPackages_latest; #_4_19; # _latest;

  # Bootloader.
  
  boot = { 
    loader = {
      grub = {
        enable = true;
        device = "/dev/sdb";
        useOSProber = true;
      };
    };

    # kernelParams = [ "module_blacklist=i915" ]; # Blacklist integrated GPU
    kernelParams = [ "nvidia-drm.modeset=1" ];
  };

  environment = {
    sessionVariables = rec {
      WLR_NO_HARDWARE_CURSORS = "1"; # Should fix cursor disappearing sometimes??
      NIXOS_OZONE_WL = "1"; # Force wayland on electron apps.
    };
  };

  networking = {
    networkmanager.enable = true; # Enable networking
    hostName = "nixos"; # Define your hostname.
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";

  fonts.packages = with pkgs; [
    # font-awesome
    (nerdfonts.override {
      fonts = [ 
        # "FiraCode"
			  "EnvyCodeR"
      ];
    })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  ## Configure keymap in X11
  #services.xserver = {
  #  # Enable the X11 windowing system.
  #  enable = true;

  #  # Enable the GNOME Desktop Environment.
  #  displayManager.gdm.enable = true;

  # # Enable automatic login for the user.
    #displayManager.autoLogin.enable = true;
    #displayManager.autoLogin.user = "fred";

    # Load nvidia driver for Xorg and Wayland
    #videoDrivers = [
    #  # "intel"
    #  "nvidia"
    #];
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    fred = {
      isNormalUser = true;
      description = "Fred";
			# useDefaultShell = true;
			shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  security = {
    polkit.enable = true;

    sudo = {
      enable = true;
      extraRules = [{
       commands = [
         { 
      	    command = "${pkgs.systemd}/bin/reboot";
      	    options = [ "NOPASSWD" ];
      	  }
      	];
      	groups = [ "wheel" ];
      }];
      #configFile = ''
      #  %wheel ALL=(ALL) ALL
      #'';
    };
  };

  virtualisation = {
    libvirtd.enable = true;
  };

  #nixpkgs.config.packageOverrides = pkgs: {
  #  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  #};

  # Enable sound with pipewire.
  sound.enable = true;
  
  hardware = {
    pulseaudio.enable = false;
    # pulseaudio.support32Bit= true;
    # pulseaudio.package = pkgs.pulseaudioFull;
		bluetooth = {
      enable = true; # enables support for bluetooth
			powerOnBoot = true; # powers up default bluetooth controller on boot
		};

    # Enable OpenGL
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      #extraPackages = with pkgs; [
      #  intel-media-driver # LIBVA_DRIVER_NAME=iHD
      #  vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      #  vaapiVdpau
      #  libvdpau-va-gl
      #];
    };

    nvidia = {
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = config.boot.kernelPackages.nvidiaPackages.production;

      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = false;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Do not disable this unless your GPU is unsupported or if you have a good reason to.
      open = false;

      # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
      nvidiaSettings = true;
    };
  };
    
  security.rtkit.enable = true;
  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
		# Enable blueman which provides blueman-applet and blueman-manager.
    blueman.enable = true;

    openssh = {
      enable = true;

      # authorizedKeys.keys = [
      #   ""
      # ];
    };

    pipewire = {
      enable = true;
      
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
  
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

		xserver = {
      enable = true;

      excludePackages = with pkgs; [
        xterm
			];

      videoDrivers = [
        "nvidia"
      ];
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      # Certain features, including CLI integration and system authentication support,
      # require enabling PolKit integration on some desktop environments (e.g. Plasma).
      polkitPolicyOwners = [ "fred" ];
    };

    dconf.enable = true; # At the time, this was for Blueman & virt-manager
    
		fish.enable = true;
	};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
		bluetuith # Terminal based bluetooth manager
    htop
    lm_sensors 
    # conky
    neovim 
    ripgrep # for "telescope" inside neovim
		#fzf # for telescope in neovim
    gnome.nautilus # file explorer
    alacritty # terminal
    screenfetch
    wl-clipboard # clipboard
    waybar # status bar
    rofi-wayland # launcher
    hyprpicker # color picker tool
    hyprpaper # backgrounds
    wlogout # logout screen
		# NODE
		nodejs
		# RUST
		cargo
		rustc
		gcc
		# 
  ];

  


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
