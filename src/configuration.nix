# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, username, hostname, ... }:
{
  imports = [ 
	  # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix = {
		settings = {
      experimental-features = [ "nix-command" "flakes" ];
      
      auto-optimise-store = true;
		};

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
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
        device = "/dev/sda";
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
      # LocalSend Download directory
      XDG_DOWNLOAD_DIR = "~/Downloads";
      XCURSOR_SIZE = "28";
    };
  };

  networking = {
    networkmanager.enable = true; # Enable networking
    hostName = hostname; # Define your hostname.

    firewall = {
      enable = true;
      
      allowedTCPPorts = [ 
        80
        443
        53317 # for LocalSend
      ];

      allowedUDPPortRanges = [
        { from = 4000; to = 4007; }
        { from = 53315; to = 53318; }
        { from = 8000; to = 8010; }
      ];
    };
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

  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;

    overlays = [
       (final: prev: {
        libratbag = prev.libratbag.overrideAttrs (o: {
          src = prev.fetchFromGitHub {
              owner = "libratbag";
              repo = "libratbag";
              rev = "22ddb717aa1095e23f0e5a128b607c9805bc6110";
              sha256 = "sha256-y7QOyfTzMNCz4Lv2YW5OR7teoNW1lSXJ1ixVZk8yMDg=";
          };
        });
        
        piper = prev.piper.overrideAttrs (o: {
          src = prev.fetchFromGitHub {
              owner = "libratbag";
              repo = "piper";
              rev = "c15910bf59d95279469c00c2a84d26dce2bfacbf";
              sha256 = "sha256-dwwLxoIjyGATvc+26rYwYevm4KJxIcbMdvuBCMGr77Y=";
          };
          
          mesonFlags = [
            "-Druntime-dependency-checks=false"
            # "-Dtests=false"
          ];
        });

        github-desktop = prev.github-desktop.overrideAttrs (o: rec {
          pname = "github-desktop";
          version = "3.3.8";
          rcversion = "2";
          arch = "amd64";

          src = prev.fetchurl {
            url = "https://github.com/shiftkey/desktop/releases/download/release-${version}-linux${rcversion}/GitHubDesktop-linux-${arch}-${version}-linux${rcversion}.deb";
            hash = "sha256-MXtEIVEsd5GAPGuxMHcFLJ/M009lPRnX6h+kj5UlSG8=";
          };
        });
      })
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
	  groups = {
      games = { };
      plugdev = { }; # added for Ledger Live
		};
	  users = {
      ${username} = {
			  shell = pkgs.fish;

        isNormalUser = true;
        description = "Fred";

        extraGroups = [ 
          "networkmanager"
          "wheel"
          "games"
          "plugdev"
          "libvirtd"
          "docker"
          "audio"
          "disk"
        ];
      };
		};

    extraGroups = {
      vboxusers.members = [ username ];
    };
  };

  security = {
	  rtkit.enable = true;

    polkit.enable = true;

    sudo = {
      enable = true;
    };

		pam.services.greetd.enableGnomeKeyring = true;
  };

  virtualisation = {
    libvirtd.enable = true;
		docker.enable = true;

    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
      # guest = {
      #   enable = true;
      #   x11 = true;
      # };
    };
  };

  # Enable sound with pipewire.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  
  hardware = {
    pulseaudio.enable = false;
    pulseaudio.support32Bit= true;
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
      extraPackages = with pkgs; [
      #  intel-media-driver # LIBVA_DRIVER_NAME=iHD
      #  vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      #  vaapiVdpau
      #  libvdpau-va-gl
        intel-compute-runtime
      ];
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
      
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;
      
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
      packages = with pkgs; [
        logitech-udev-rules
      ];

      # Get the idVendor and idProduct from lsusb. eg: "Bus 003 Device 004: ID 3434:0220 Keychron Keychron K2 Pro".
      extraRules = ''
        # Required for my KeyChron K2 Pro keyboard in order to use https://usevia.app. 
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0220", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

        # Required for Ledger Live to detect Ledger Nano X via USB
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="4011", MODE="0660", GROUP="plugdev"
      '';

      # extraRules = ''
      #   # Allows non-root users to have raw access to Logitech devices.
      #   # Allowing users to write to the device is potentially dangerous
      #   # because they could perform firmware updates.
      #   KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
      # '';
    };

		xserver = {
      enable = true;

      excludePackages = with pkgs; [
        xterm
			];

      videoDrivers = [
        "nvidia"
      ];

			displayManager.autoLogin = {
        enable = true;
				user = username;
			};

			# Enable touchpad support (enabled default in most desktopManager).
      # libinput.enable = true;
    };

		gnome = {
			gnome-keyring.enable = true;
		};

    # Added this so that i can see the Devices in Nemo.
    gvfs = {
      enable = true;
    };
  };

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      # Certain features, including CLI integration and system authentication support,
      # require enabling PolKit integration on some desktop environments (e.g. Plasma).
      polkitPolicyOwners = [ username ];
    };

    dconf.enable = true; # At the time, this was for Blueman & virt-manager
    
		fish.enable = true;

    solaar.enable = true;

		#virt-manager.enable = true;
	};

	xdg = {
    portal = {
      enable = true;
      config = {
        # xdg-desktop-portal 1.17 reworked how portal implementations are loaded, you
        # should either set `xdg.portal.config` or `xdg.portal.configPackages`
        # to specify which portal backend to use for the requested interface.
        # If you simply want to keep the behaviour in < 1.17, you can set this to "*".
        common.default = "*";
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland # For screensharing
        xdg-desktop-portal-gtk # For File Chooser
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
		bluetuith # Terminal based bluetooth manager
    btop
    lm_sensors
    neovim 
    ripgrep # for "telescope" inside neovim
    cinnamon.nemo # file explorer
    cinnamon.nemo-fileroller # file archiver
    # xplorer # file explorer
		ranger
    alacritty # terminal
    screenfetch
    wl-clipboard # clipboard
    waybar # status bar
    rofi-wayland # launcher
    hyprpicker # color picker tool
    hyprpaper # backgrounds
    wlogout # logout screen
    pulseaudio # exposes pactl
		pavucontrol
    qpwgraph # graph manager dedicated to pipewire
    pamixer
    wev # wayland event viewer
		# # NODE
		nodejs
		# RUST
		cargo
		rustc
		rust-analyzer
		rustfmt
		# PYTHON
		python3
		#
	  gcc
		gnumake
		unzip
		xdg-utils
		libsecret #
    #
    usbutils
    #
    dig
  ];
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  
}
