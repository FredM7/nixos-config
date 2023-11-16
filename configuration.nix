# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports = [ 
	  # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix = {
		settings = {
      experimental-features = [ "nix-command" "flakes" ];
		};
  };

	# Before changing the system.stateVersion, read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

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
      # Should fix cursor disappearing sometimes?? For some reason the moment I 
			# added this, my system stopped crashing (at time of writing).
      WLR_NO_HARDWARE_CURSORS = "1";
      # Force wayland on electron apps.
			NIXOS_OZONE_WL = "1";
			# This is for VSCode/Codium rust-analyzer to work.
			RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
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
    # font-awesome # it broke my fonts!!?
    (nerdfonts.override {
      fonts = [ 
			  "EnvyCodeR"
      ];
    })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
	  groups = {
      games = { };
		};
	  users = {
      fred = {
        isNormalUser = true;
        description = "Fred";
			  shell = pkgs.fish;
        extraGroups = [ "networkmanager" "wheel" "games" "libvirtd" "docker" ];
      };
		};
  };

  security = {
    polkit.enable = true;

    sudo = {
      enable = true;
    };
  };

  virtualisation = {
    libvirtd.enable = true;
		docker.enable = true;
  };

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

      # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
      nvidiaSettings = true;
    };
  };
    
  security.rtkit.enable = true;
  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
		# Enable blueman which provides blueman-applet and blueman-manager.
    # blueman.enable = true;
    
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
      
			# For screen sharing?
			wireplumber = {
        enable = true;
		  };

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

		# For Piper to work.
		ratbagd = {
      enable = true;
		};

		udev = {
      extraRules = ''
# This rule was added for Solaar.
#
# Allows non-root users to have raw access to Logitech devices.
# Allowing users to write to the device is potentially dangerous
# because they could perform firmware updates.
KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"

ACTION != "add", GOTO="solaar_end"
SUBSYSTEM != "hidraw", GOTO="solaar_end"

# USB-connected Logitech receivers and devices
ATTRS{idVendor}=="046d", GOTO="solaar_apply"

# Lenovo nano receiver
ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="6042", GOTO="solaar_apply"

# Bluetooth-connected Logitech devices
KERNELS == "0005:046D:*", GOTO="solaar_apply"

GOTO="solaar_end"

LABEL="solaar_apply"

# Allow any seated user to access the receiver.
# uaccess: modern ACL-enabled udev
TAG+="uaccess"

# Grant members of the "plugdev" group access to receiver (useful for SSH users)
#MODE="0660", GROUP="plugdev"

LABEL="solaar_end"
# vim: ft=udevrules
			'';
		};

		xserver = {
      enable = true;

      excludePackages = with pkgs; [
        xterm
			];

      videoDrivers = [
        "nvidia"
      ];

			# Enable touchpad support (enabled default in most desktopManager).
      # libinput.enable = true;
    };
  };

  

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

		#virt-manager.enable = true;
	};

	xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      # xdg-desktop-portal-wlr
      # xdg-desktop-portal-kde
      # xdg-desktop-portal-gtk
			xdg-desktop-portal-hyprland
    ];
	};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
		bluetuith # Terminal based bluetooth manager
    btop
    lm_sensors 
    # conky
    neovim 
    ripgrep # for "telescope" inside neovim
		#fzf # for telescope in neovim
    gnome.nautilus # file explorer
		# krusader
		# whitesur-icon-theme
		# libsForQt5.dolphin
		#libsForQt5.qt5ct
		ranger
    alacritty # terminal
    screenfetch
    wl-clipboard # clipboard
    waybar # status bar
    rofi-wayland # launcher
    hyprpicker # color picker tool
    hyprpaper # backgrounds
    wlogout # logout screen
		pavucontrol
		# NODE
		nodejs
		# RUST
		cargo
		rustc
		gcc
		rust-analyzer
		rustfmt
		# PYTHON
		python3
		#
		gnumake
		unzip
		nwg-look
		xdg-utils
		# xwaylandvideobridge
		# xdg-desktop-portal-hyprland
		# TODO these needs to move to home.nix
		solaar
  ];
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  
}
